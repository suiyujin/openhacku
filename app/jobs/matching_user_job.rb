class MatchingUserJob < ActiveJob::Base
  queue_as :default

  def perform(ticket)
    matching_user_ids = MatchingTicket.search_matching_user(ticket)
    MatchingTicket.create(make_matching_ticket(matching_user_ids, ticket.id))

    # TODO: お互いに通知する
  end

  private

  def make_matching_ticket(user_ids, ticket_id)
    user_ids.map { |user_id| Hash[*['user_id', 'ticket_id'].zip([user_id, ticket_id]).flatten] }
  end
end
