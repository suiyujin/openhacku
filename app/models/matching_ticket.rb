class MatchingTicket < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user

  def self.search_matching_user(ticket)
    users = User.includes(:keywords).select(:id).order(:id)

    match_num_users_keywords = users.map(&:keywords).map do |user_keywords|
      user_keywords_ids = user_keywords.map(&:id)
      ticket_keywords_ids = ticket.keywords.map(&:id)
      (user_keywords_ids & ticket_keywords_ids).size
    end
    match_num_users_keywords_hash = (1..match_num_users_keywords.size).zip(match_num_users_keywords).to_h
    match_num_users_keywords_hash_select = match_num_users_keywords_hash.select do |key, value|
      value > 0
    end
    match_num_users_keywords_sort = match_num_users_keywords_hash_select.sort_by do |key, value|
      -value
    end.map{ |hash| hash[0] }

    if match_num_users_keywords_sort.size >= 10
      # 先頭10人をマッチングユーザーとする
      match_num_users_keywords_sort.delete(ticket.user_id)
      return match_num_users_keywords_sort[0, 10]
    elsif match_num_users_keywords_sort.blank?
      # カテゴリーまで広げて探す
      match_num_users_categories = users.map(&:keywords).map do |user_keywords|
        user_categories_ids = user_keywords.map(&:category).uniq.map(&:id)
        ticket_categories_ids = ticket.keywords.map(&:category).uniq.map(&:id)
        (user_categories_ids & ticket_categories_ids).size
      end
      match_num_users_categories_hash = (1..match_num_users_categories.size).zip(match_num_users_categories).to_h
      match_num_users_categories_hash_select = match_num_users_categories_hash.select do |key, value|
        value > 0
      end
      match_num_users_categories_sort = match_num_users_categories_hash_select.sort_by do |key, value|
        -value
      end.map{ |hash| hash[0] }

      match_num_users_categories_sort.delete(ticket.user_id)
      return match_num_users_categories_sort[0, 10]
    else
      # 全てのユーザーをマッチングユーザーとして、残りをカテゴリーから探す
      match_users_ids = match_num_users_keywords_sort

      users_id_keywords = users.where.not(id: match_users_ids).map do |user|
        {
          id: user.id,
          keywords: user.keywords
        }
      end
      match_num_users_categories = users_id_keywords.map do |user_id_keywords|
        user_categories_ids = user_id_keywords[:keywords].map(&:category).uniq.map(&:id)
        ticket_categories_ids = ticket.keywords.map(&:category).uniq.map(&:id)
        {
          id: user_id_keywords[:id],
          match_num: (user_categories_ids & ticket_categories_ids).size
        }
      end

      match_num_users_categories_select = match_num_users_categories.select do |user|
        user[:match_num] > 0
      end

      match_users_ids.concat(
        match_num_users_categories_select.sort_by do |mn|
          -mn[:match_num]
        end.map { |m| m[:id] }
      )

      match_users_ids.delete(ticket.user_id)
      return match_users_ids[0, 10]
    end
  end
end
