class SessionsController < Devise::SessionsController
  def create
    super do |resource|
      resource.ensure_authentication_token if request.format.json?
    end
  end

  def respond_with(resource, opts = {})
    teached_num = Ticket.where(bought_user_id: resource.id).count
    learned_num = resource.tickets.where(bought: true).count
    scores = resource.review_users_of_to_user.map(&:score)
    review_ave = scores.blank? ? nil : (scores.inject(&:+) / scores.count.to_f).round(1)

    render json: {
      id: resource.id,
      email: resource.email,
      authentication_token: resource.authentication_token,
      last_name: resource.last_name,
      first_name: resource.first_name,
      username: resource.username,
      sex: resource.sex,
      introduction: resource.introduction,
      profile_img_url: resource.profile_img_url,
      header_img_url: resource.header_img_url,
      review_ave: review_ave,
      teached_num: teached_num,
      learned_num: learned_num,
      tags: resource.keywords
    }
  end
end
