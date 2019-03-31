class Book < ApplicationRecord
  serialize :authors, Array
end
