class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:update, :destroy]

  def update
    if @user.update(user_params)
      # update keywords_users
      #if params[:user][:tags].present?
      #  KeywordsUser.where(user_id: @user.id).each(&:destroy)
      #  keywords = params[:user][:tags].map { |keyword_id| Hash[*['keyword_id', 'user_id'].zip([keyword_id, @user.id]).flatten] }
      #  KeywordsUser.create(keywords)
      #end

      @teached_num = Ticket.where(bought_user_id: @user.id).count
      @learned_num = @user.tickets.where(bought: true).count
      @stock_num = @user.stock_tickets.count

      # 評価の平均値
      scores = @user.review_users_of_to_user.map(&:score)
      @review_ave = scores.blank? ? nil : (scores.inject(&:+) / scores.count.to_f).round(1)

      render "show", :formats => [:json], :handlers => [:jbuilder]
    else
      render json: @user.errors, status: :unprocessable_entity
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
