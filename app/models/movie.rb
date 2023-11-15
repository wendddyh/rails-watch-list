class Movie < ApplicationRecord
  has_many :bookmarks
  before_destroy :bookmarks
  validates :title, :overview, presence: true
  validates :title, uniqueness:  true
end
