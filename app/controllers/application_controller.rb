class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # allow cross domain
  before_filter :allow_cross_domain_access
  def allow_cross_domain_access
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "*"
  end

  # json でのリクエストの場合CSRFトークンの検証をスキップ
  skip_before_action :verify_authenticity_token, if: -> {request.format.json?}
  # トークンによる認証
  before_action :authenticate_user_from_token!, if: -> {params[:user].present? && params[:user][:token].present?}
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 権限無しのリソースにアクセスしようとした場合
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to main_app.root_url, alert: exception.message }
      format.json { render json: {message: exception.message}, status: :unauthorized }
    end
  end

  # トークンによる認証
  def authenticate_user_from_token!
    user = User.find_by(authentication_token: params[:user][:token])
    sign_in user, store: false
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :introduction]
  end
end
