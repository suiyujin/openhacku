class RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      # create keywords_users
      keywords = params[:user][:keywords].map { |keyword_id| Hash[*['keyword_id', 'user_id'].zip([keyword_id, resource.id]).flatten] }
      KeywordsUser.create(keywords)
    end
  end

  def respond_with(resource, opts = {})
    render json: {
      id: resource.id,
      email: resource.email,
      name: resource.name,
      introduction: resource.introduction
    }
  end
end
