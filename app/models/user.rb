class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # 認証トークンはユニーク。ただしnilは許可
  validates:authentication_token, uniqueness: true, allow_nil: true
  has_many :tickets, dependent: :delete_all
  has_many :bought_tickets, class_name: 'Ticket', foreign_key: 'bought_user_id'
  has_many :stock_tickets, dependent: :delete_all
  has_many :keywords_users, dependent: :delete_all
  has_many :keywords, through: :keywords_users
  has_many :ticket_candidates, dependent: :delete_all
  has_many :want_to_buy_tickets, through: :ticket_candidates
  has_many :matching_tickets, dependent: :delete_all

  # review association
  has_many :review_users_of_to_user, class_name: 'Review', foreign_key: 'to_user_id', dependent: :delete_all
  has_many :reviews_of_to_user, through: :review_users_to_user, source: 'from_user_review'
  has_many :review_users_of_from_user, class_name: 'Review', foreign_key: 'from_user_id', dependent: :delete_all
  has_many :reviews_of_from_user, through: :review_users_from_user, source: 'to_user_review'

  # 認証トークンが無い場合は作成
  def ensure_authentication_token
    self.authentication_token || generate_authentication_token
  end

  # 認証トークンの作成
  def generate_authentication_token
    loop do
      old_token = self.authentication_token
      token = SecureRandom.urlsafe_base64(24).tr('lIO0', 'sxyz')
      break token if (self.update!(authentication_token: token) rescue false) && old_token != token
    end
  end

  def delete_authentication_token
    self.update(authentication_token: nil)
  end
end
