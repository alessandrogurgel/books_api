class Book < ApplicationRecord
  serialize :authors, Array

  validates :name, presence: true
end
