class MailTestJob < ActiveJob::Base
  queue_as :default

  def perform
    matching_user_ids = [1,8,9]
    ticket = Ticket.find(94)
    # お互いに通知する
    MatchingMailer.for_matching_user(matching_user_ids, ticket).deliver_later
    # MatchingMailer.for_creating_user(matching_user_ids, ticket).deliver_now
  end
end
