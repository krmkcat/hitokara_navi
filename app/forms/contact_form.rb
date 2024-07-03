class ContactForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :email, :string
  attribute :body, :string
  attribute :user_id, :integer

  # attr_reader :subjects

  # def subjects=(value)
  #   @subjects = value.reject(&:blank?).map(&:to_i)
  # end

  validates :email, presence: true
  validates :body, presence: true, length: { maximum: 2000 }
  # validates :subjects, presence: true
end
