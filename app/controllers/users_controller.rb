class UsersController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource only: [:show]
  before_action :set_user, only: [:show, :update, :select_tags, :destroy]

  def show
      @teached_num = Ticket.where(bought_user_id: @user.id).count
      @learned_num = @user.tickets.where(bought: true).count
      @stock_num = @user.stock_tickets.count
  end

  def update
    if @user.update(user_params)
      @teached_num = Ticket.where(bought_user_id: @user.id).count
      @learned_num = @user.tickets.where(bought: true).count
      @stock_num = @user.stock_tickets.count

      render "show", :formats => [:json], :handlers => [:jbuilder]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def select_tags
    # update keywords_users
    if params[:user][:tags].present?
      KeywordsUser.where(user_id: @user.id).each(&:destroy)
      keywords = params[:user][:tags].map { |keyword_id| Hash[*['keyword_id', 'user_id'].zip([keyword_id, @user.id]).flatten] }
      if KeywordsUser.create(keywords)
        render "show", :formats => [:json], :handlers => [:jbuilder]
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @user.destroy
    render json: { message: 'User was successfully destroyed.' }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :username, :last_name, :first_name, :sex, :introduction)
  end
end
