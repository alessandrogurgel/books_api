class Book < ApplicationRecord
  serialize :authors, Array

  validates :name, presence: true

  def as_json(options)
    excluded_fields = [:created_at, :updated_at, :id]
    super(options.merge(except: excluded_fields)).merge(
      {
        release_date: self.release_date.to_s(:db)
      })
  end
end
