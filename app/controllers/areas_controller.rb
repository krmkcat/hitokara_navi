class AreasController < ApplicationController
  skip_before_action :require_login

  def index
    @prefecture = Prefecture.find(params[:prefecture_id])
    render layout: false, content_type: 'text/vnd.turbo-stream.html'
  end
end
