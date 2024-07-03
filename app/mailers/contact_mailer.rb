class ContactMailer < ApplicationMailer
  def contact_email
    mail to: GMAIL_USERNAME, subject: "問い合わせ(#{contact_id})"
  end
end
