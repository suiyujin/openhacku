class MailTestJob < ActiveJob::Base
  queue_as :email

  def perform
    MatchingMailer.test_mail.deliver_now
   # matching_user_ids = [1,8,9]
   # ticket = Ticket.find(94)
   # # お互いに通知する
   # MatchingMailer.for_matching_user(matching_user_ids, ticket).deliver_now
   # # MatchingMailer.for_creating_user(matching_user_ids, ticket).deliver_now
  end
end
