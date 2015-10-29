class TicketsController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource only: [:index, :show, :stock, :buy, :unstock]
  before_action :set_ticket, only: [:show, :edit, :update, :buy, :destroy]
  before_action :set_default_if_no_params, only: [:index, :my_list]

  DEFAULT_SORT = 'create'
  DEFAULT_SORT_STOCK = 'stock'
  DEFAULT_ORDER = 'd'
  DEFAULT_LIMIT = 10
  DEFAULT_OFFSET = 0
  DEFAULT_FILTER = 'all'

  # GET /tickets
  # GET /tickets.json
  def index
    # filterがteachedまたはlearnedまたはstockの時はuser_idが必要
    if ['teached', 'learned', 'stock'].include?(params[:filter]) && params[:user_id].blank?
      render json: { message: 'ERROR: need user_id parameter!' }, status: 500
    end

    query = Ticket.includes(:user, :bought_user, :keywords).order_limit_offset(make_order_query, params[:limit], params[:offset])

    # 性別でフィルタリング
    query = query.joins_users_where_sex(params[:sex]) if params[:sex].present?

    case params[:filter]
    when 'no_bought' then
      query = query.no_bought
      query = query.user(params[:user_id]) if params[:user_id].present?
    when 'teached' then
      query = query.bought_user(params[:user_id])
    when 'learned' then
      query = query.user(params[:user_id]).bought
    when 'stock' then
      query = query.no_bought.joins_stock_tickets_where_user(params[:user_id])
    end

    @tickets = query
  end

  def my_list
    @tickets = Ticket.includes(:user, :bought_user).accessible_by(current_ability).no_bought.order_limit_offset(make_order_query, params[:limit], params[:offset])
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params.merge(user: current_user))

    respond_to do |format|
      if @ticket.save
        # create keywords_tickets
        keywords = params[:ticket][:tags].map { |keyword_id| Hash[*['keyword_id', 'ticket_id'].zip([keyword_id, @ticket.id]).flatten] }
        KeywordsTicket.create(keywords)

        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /tickets/1/stock.json
  def stock
    @stock_ticket = StockTicket.new(ticket_id: params[:id], user_id: current_user.id)

    if @stock_ticket.save
      render json: { message: 'Ticket was successfully stocked.' }
    else
      render json: @stock_ticket.errors, status: :unprocessable_entity
    end
  end

  # PATCH /tickets/1/buy.json
  def buy
    unless @ticket.user_id == current_user.id || @ticket.bought
      @ticket.update_attributes(bought: true, bought_user_id: current_user.id)
      render json: { message: 'Ticket was successfully bought.' }
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        # update keywords_tickets
        if params[:ticket][:tags].present?
          KeywordsTicket.where(ticket_id: @ticket.id).each(&:destroy)
          keywords = params[:ticket][:tags].map { |keyword_id| Hash[*['keyword_id', 'ticket_id'].zip([keyword_id, @ticket.id]).flatten] }
          KeywordsTicket.create(keywords)
        end

        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1/stock.json
  def unstock
    StockTicket.find_by(ticket_id: params[:id], user_id: current_user.id).destroy
    render json: { message: 'Ticket was successfully unstocked.' }
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { render json: { message: 'Ticket was successfully destroyed.' } }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:title, :body, :time, :price, :place, :bought, :user_id, :bought_user_id, :beginner)
    end

    def set_default_if_no_params
      params[:sort] ||= (params[:filter] == 'stock') ? DEFAULT_SORT_STOCK : DEFAULT_SORT
      params[:order] ||= DEFAULT_ORDER
      params[:limit] ||= DEFAULT_LIMIT
      params[:offset] ||= DEFAULT_OFFSET
      params[:filter] ||= DEFAULT_FILTER
    end

    def make_order_query
      case params[:order]
      when 'd' then
        order_query = ' desc'
      when 'a' then
        order_query = ' asc'
      end

      case params[:sort]
      when 'create' then
        'tickets.id' + order_query
      when 'stock' then
        'stock_tickets.id' + order_query
      else
        params[:sort] + order_query + ', tickets.id desc'
      end
    end
end
