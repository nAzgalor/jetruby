class Hotel < ApplicationRecord
  validates :title, presence: true
  validates :star_rating_owner, presence: true
  validates :star_rating_owner, inclusion: { in: [1, 2, 3, 4, 5], message: "%{value} not valid" }

  has_many :comments
  belongs_to :user

  mount_uploader :photo, PhotoUploader

  after_create :star_rating_default

  scope :top_5_hotels, -> { order('star_rating DESC').limit(5) }

  def owner_hotel?(user_id)
    user_id == self.user_id
  end

  private

  def star_rating_default
    self.update(star_rating: star_rating_owner)
  end
end
