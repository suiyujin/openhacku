class RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      raise "ERROR: #{resource.email} is exists." if resource.id.nil?
      resource.ensure_authentication_token if request.format.json?
    end
  end

  def respond_with(resource, opts = {})
    render json: {
      id: resource.id,
      email: resource.email,
      authentication_token: resource.authentication_token
    }
  end
end
