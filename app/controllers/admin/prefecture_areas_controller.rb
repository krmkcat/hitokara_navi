class Admin::PrefectureAreasController < Admin::BaseController
  def index
    @prefecture = Prefecture.find(params[:prefecture_id])
  end
end
