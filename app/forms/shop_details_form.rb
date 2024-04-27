class ShopDetailsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :int_average, :integer
  attribute :eqcust_average, :integer
  attribute :sofr_average, :integer

  attr_reader :tag_ids

  def tag_ids=(value)
    @tag_ids = value.reject(&:blank?).map(&:to_i)
  end

  def search(relation)
    relation = search_with_ratings(relation)
    relation = relation.by_tag_ids(tag_ids) if tag_ids.present?
    relation
  end

  private

  def search_with_ratings(relation)
    relation = relation.by_int_average(int_average) if int_average.present?
    relation = relation.by_eqcust_average(eqcust_average) if eqcust_average.present?
    relation = relation.by_sofr_average(sofr_average) if sofr_average.present?
    relation
  end
end
