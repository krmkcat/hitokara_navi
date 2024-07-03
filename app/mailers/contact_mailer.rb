class ContactMailer < ApplicationMailer
  def contact_email
    @contact_id = SecureRandom.uuid
    @user = User.find_by(id: params[:user_id])
    @body = params[:body]
    mail to: ENV['GMAIL_USERNAME'], subject: "問い合わせ(#{@contact_id})"
  end
end
