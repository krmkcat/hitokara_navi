class AreasController < ApplicationController
  skip_before_action :require_login

  def index
    @prefecture = Prefecture.find(params[:prefecture_id])
  end
end
