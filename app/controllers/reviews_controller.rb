class ReviewsController < ApplicationController
  def index
    @reviews = Review.where(to_user_id: params[:user_id])
  end

  def create
    @review = Review.new(review_params.merge(from_user_id: current_user.id))
    ticket = Ticket.select(:id, :user_id).find(params[:ticket_id])
    @review.ticket_id = ticket.id
    @review.to_user_id = ticket.user_id

    # 自分のチケットには評価できない & すでに評価したチケットは評価できない
    if ticket.user_id != current_user.id && Review.where(ticket_id: ticket.id, to_user_id: ticket.user_id).count == 0 && @review.save
      # Userのreview_aveを更新
      to_user = User.find_by(id: @review.to_user_id)
      scores = to_user.review_users_of_to_user.map(&:score)
      review_ave = scores.blank? ? nil : (scores.inject(&:+) / scores.count.to_f).round(1)
      to_user.update_attribute(:review_ave, review_ave)

      render "show", :formats => [:json], :handlers => [:jbuilder]
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:score, :comment)
  end
end
