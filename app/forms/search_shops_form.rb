class SearchShopsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :words, :string
  attribute :int_average, :integer
  attribute :eqcust_average, :integer
  attribute :sofr_average, :integer
  attribute :prefecture_id, :integer
  attribute :area_id, :integer
  attribute :latitude, :decimal
  attribute :longitude, :decimal

  attr_reader :tag_ids

  def tag_ids=(value)
    @tag_ids = value.reject(&:blank?).map(&:to_i)
  end

  def search
    relation = Shop.distinct

    relation = relation.by_prefecture_id(prefecture_id) if prefecture_id.present?
    relation = relation.by_area_id(area_id) if area_id.present?
    relation = search_with_name_or_address(relation) if words.present?
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

  def search_words
    words.present? ? words.split(/[[:blank:]]+/) : []
  end

  def search_with_name_or_address(relation)
    search_words.inject(relation) do |rel, word|
      rel.name_or_address_contain(word)
    end
  end
end
