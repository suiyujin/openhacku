class MatchingUserJob < ActiveJob::Base
  queue_as :default

  def perform(ticket)
    matching_user_ids = MatchingTicket.search_matching_user(ticket)
    Rails.logger.info("matching_user_ids: #{matching_user_ids}")
    MatchingTicket.create(make_matching_ticket(matching_user_ids, ticket.id))
    Rails.logger.info("matching_user created.")

    # お互いに通知する
    # MatchingMailer.for_matching_user(matching_user_ids, ticket).deliver_now
    # MatchingMailer.for_creating_user(matching_user_ids, ticket).deliver_now
  end

  private

  def make_matching_ticket(user_ids, ticket_id)
    user_ids.map { |user_id| Hash[*['user_id', 'ticket_id'].zip([user_id, ticket_id]).flatten] }
  end
end
