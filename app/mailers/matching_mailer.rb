class MatchingMailer < ApplicationMailer
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.matching_mailer.test_mail.subject
  #
  def test_mail
    @greeting = "Hi"

    mail to: "suiyujin04@gmail.com", subject: "ActionMailer test"
  end

  def for_matching_user(matching_user_ids, ticket)
    mail_addresses = matching_user_ids.map do |matching_user_id|
      User.find(matching_user_id).email
    end
    @ticket = ticket
    mail to: mail_addresses, subject: "chiepittan test mail"
  end

  def for_creating_user(matching_user_ids, ticket)
    @matching_users = matching_user_ids.map do |matching_user_id|
      User.find(matching_user_id)
    end
    @ticket = ticket
    mail to: ticket.user.email, subject: "chiepittan test mail"
  end
end
