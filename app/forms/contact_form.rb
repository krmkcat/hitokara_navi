class ContactForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :email, :string
  attribute :body, :string
  attribute :user_id, :integer

  attr_reader :inquiry_types

  def inquiry_types=(value)
    @inquiry_types = value.reject(&:blank?).map(&:to_i)
  end

  validates :email, presence: true
  validates :body, presence: true, length: { maximum: 2000 }
  validates :inquiry_types, presence: true

  def self.inquiry_type_options
    %w[質問 不具合の報告 要望 その他]
  end
end
