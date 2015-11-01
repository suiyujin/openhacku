json.reviews do
  json.array! @reviews, partial: 'reviews/review', as: :review
end
