class ContactsController < ApplicationController
  skip_before_action :require_login

  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.new(contact_params)
    if @contact_form.valid?
      send_emails
      redirect_to root_path, success: t('.success')
    else
      flash.now[:error] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact_form).permit(:email, :body, :user_id, inquiry_types: [])
  end

  def send_emails
    @contact_id = SecureRandom.uuid
    ContactMailer.with(contact_id: @contact_id, user_id: @contact_form.user_id, email: @contact_form.email, body: @contact_form.body, inquiry_types: @contact_form.inquiry_types).contact_email.deliver_now
    ContactMailer.with(email: @contact_form.email, contact_id: @contact_id, inquiry_types: @contact_form.inquiry_types, body: @contact_form.body).contact_copy_email.deliver_now
  end
end
