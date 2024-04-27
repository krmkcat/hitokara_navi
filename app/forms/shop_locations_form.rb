class ShopLocationsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :words, :string
  attribute :prefecture_id, :integer
  attribute :area_id, :integer

  def search
    relation = Shop.distinct

    relation = relation.by_prefecture_id(prefecture_id) if prefecture_id.present?
    relation = relation.by_area_id(area_id) if area_id.present?
    relation = search_with_name_or_address(relation) if words.present?
    relation
  end

  private

  def search_words
    words.present? ? words.split(/[[:blank:]]+/) : []
  end

  def search_with_name_or_address(relation)
    search_words.inject(relation) do |rel, word|
      rel.name_or_address_contain(word)
    end
  end
end
