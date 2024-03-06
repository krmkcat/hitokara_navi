class ProfilesController < ApplicationController
  before_action :set_profile

  def show; end

  def edit
  end

  def update
  end

  private

  def set_profile
    @profile = User.find(current_user.id).profile
  end
end
