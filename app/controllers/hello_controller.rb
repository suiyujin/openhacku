class HelloController < ApplicationController
  def index
    render json: { message: 'Hello!' }
  end
end
