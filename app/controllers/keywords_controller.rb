class KeywordsController < ApplicationController
  def index
    query = Keyword.includes(:category)
    query = query.category(params[:category_id]) if params[:category_id].present?

    @keywords = query
  end
end
