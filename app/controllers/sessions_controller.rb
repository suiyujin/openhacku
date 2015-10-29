class SessionsController < Devise::SessionsController
  def create
    super do |resource|
      resource.ensure_authentication_token if request.format.json?
    end
  end

  def respond_with(resource, opts = {})
    teached_num = Ticket.where(bought_user_id: resource.id).count
    learned_num = resource.tickets.where(bought: true).count

    render json: {
      id: resource.id,
      email: resource.email,
      authentication_token: resource.authentication_token,
      last_name: resource.last_name,
      first_name: resource.first_name,
      username: resource.username,
      sex: resource.sex,
      teached_num: teached_num,
      learned_num: learned_num
    }
  end
end
