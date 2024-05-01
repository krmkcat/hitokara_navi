module ShopsHelper
  def search_query(search_shops_params)
    return pref_and_area(search_shops_params) if search_shops_params[:prefecture_id].present?
    return words(search_shops_params) if search_shops_params[:words].present?

    t('defaults.all')
  end

  private

  def pref_and_area(search_shops_params)
    pref = Prefecture.find_by(id: search_shops_params[:prefecture_id])&.name
    area = Area.find_by(id: search_shops_params[:area_id])&.name
    return "#{pref} #{area}" if area

    pref
  end

  def words(search_shops_params)
    "「#{search_shops_params[:words]}」"
  end
end
