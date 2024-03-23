class SearchShopsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :words, :string
  attribute :int_average, :integer
  attribute :eqcust_average, :integer
  attribute :sofr_average, :integer

  def search
    relation = Shop.distinct

    relation = relation.by_int_average(int_average) if int_average.present?
    relation = relation.by_eqcust_average(eqcust_average) if eqcust_average.present?
    relation = relation.by_sofr_average(sofr_average) if sofr_average.present?
    search_with_name_or_address(relation)
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
