class StaticPagesController < ApplicationController
  skip_before_action :require_login

  def index; end

  def privacy_policy; end
end
