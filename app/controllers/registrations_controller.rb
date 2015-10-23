class RegistrationsController < Devise::RegistrationsController
  def respond_with(resource, opts = {})
    render json: {
      id: resource.id,
      email: resource.email,
      name: resource.name,
      introduction: resource.introduction
    }
  end
end
