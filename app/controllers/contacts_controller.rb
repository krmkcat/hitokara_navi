class ContactsController < ApplicationController
  skip_before_action :require_login

  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.new(contact_params)
    if @contact_form.valid?
      ContactMailer.with(user_id: @contact_form.user_id, body: @contact_form.body).contact_email.deliver_now
      redirect_to root_path, success: t('.success')
    else
      flash.now[:error] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact_form).permit(:email, :body, :user_id)
  end
end
