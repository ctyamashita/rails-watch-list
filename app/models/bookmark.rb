class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  # validates_uniqueness_of :movie, :list, scope: [:bookmark, :id]
  validates :movie, uniqueness: { scope: :list }
  validates :comment, presence: true, length: { minimum: 6 }
end
