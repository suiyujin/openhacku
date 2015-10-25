class KeywordsController < ApplicationController
  def index
    @keywords = Keyword.includes(:category).all
  end
end
