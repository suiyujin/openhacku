class TicketsController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource only: [:index, :show, :learned, :teached, :buy]
  before_action :set_ticket, only: [:show, :edit, :update, :buy, :destroy]
  before_action :set_default_if_no_params, only: [:index, :my_list, :learned, :teached]

  DEFAULT_SORT = 'create'
  DEFAULT_ORDER = 'd'
  DEFAULT_LIMIT = 10
  DEFAULT_OFFSET = 0

  # GET /tickets
  # GET /tickets.json
  def index
    query = Ticket.includes(:user, :bought_user).no_bought.order_limit_offset(make_order_query, params[:limit], params[:offset])
    query = query.where(user_id: params[:user_id]) if params[:user_id].present?

    @tickets = query
  end

  def my_list
    @tickets = Ticket.includes(:user, :bought_user).accessible_by(current_ability).no_bought.order_limit_offset(make_order_query, params[:limit], params[:offset])
  end

  def learned
    @tickets = Ticket.includes(:user, :bought_user).user(params[:user_id]).bought.order_limit_offset(make_order_query, params[:limit], params[:offset])
  end

  def teached
    @tickets = Ticket.includes(:user, :bought_user).bought_user(params[:user_id]).order_limit_offset(make_order_query, params[:limit], params[:offset])
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
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
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
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:ticket).permit(:title, :body, :time, :price, :place, :bought, :user_id, :bought_user_id, :sex, :review_min, :level)
    end

    def set_default_if_no_params
      params[:sort] ||= DEFAULT_SORT
      params[:order] ||= DEFAULT_ORDER
      params[:limit] ||= DEFAULT_LIMIT
      params[:offset] ||= DEFAULT_OFFSET
    end

    def make_order_query
      if params[:sort] == 'create'
        if params[:order] == 'd'
          return 'id desc'
        elsif params[:order] == 'a'
          return 'id asc'
        end
      end

      case params[:order]
      when 'd' then
        order_query = "#{params[:sort]} desc"
      when 'a' then
        order_query = "#{params[:sort]} asc"
      end
      order_query += ', id desc'
    end
end
