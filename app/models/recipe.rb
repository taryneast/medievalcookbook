class Recipe < ActiveRecord::Base
  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps

  validates :name, :ingredients, presence: true
  validates :main_image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpg|jpeg|png)\Z}i,
      message: 'must be a gif, jpg or png'
    }

  # a nicer way of displaying the two time-columns (if present)
  def display_time
    return nil unless self.elapsed_time.present? || self.prep_time.present?
    val = [self.prep_time,self.elapsed_time].reject(&:blank?).map(&:to_s).join('->')
    "(#{val})"
  end
end
