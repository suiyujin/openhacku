class TicketsController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource only: [:index, :show]
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :set_limit_and_offset, only: [:index, :my_list]

  DEFAULT_LIMIT = 10
  DEFAULT_OFFSET = 0

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.includes(:user, :bought_user).where('id > ?', params[:offset]).limit(params[:limit])
  end

  def my_list
    @tickets = Ticket.includes(:user, :bought_user).accessible_by(current_ability).limit(params[:limit]).offset(params[:offset])
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
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:title, :body, :time, :price, :place, :bought, :user_id, :bought_user_id)
    end

    def set_limit_and_offset
      params[:limit] ||= DEFAULT_LIMIT
      params[:offset] ||= DEFAULT_OFFSET
    end
end
