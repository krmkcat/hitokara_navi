class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    @user = login_from(provider)
    if @user
      redirect_to root_path, success: t('.success', provider: provider.titleize)
    else
      begin
        create_user_from_provider(provider)
        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to root_path, success: t('.success', provider: provider.titleize)
      rescue StandardError => e
        logger.error e.message
        redirect_to root_path, error: t('.failure', provider: provider.titleize)
      end
    end
  end

  private

  def create_user_from_provider(provider)
    User.transaction do
      @user = create_from(provider)
      # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule
      @user.create_profile!
    end
  end

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end
end
