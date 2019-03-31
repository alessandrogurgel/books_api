class Book < ApplicationRecord
  serialize :authors, Array

  validates :name, presence: true

  scope :by_name, -> (name) { where(name: name) }
  scope :by_country, -> (country) { where(country: country) }
  scope :by_publisher, -> (publisher) { where(publisher: publisher) }
  scope :by_release_date, -> (year) { where(release_date: "#{year}-01-01".."#{year}-12-31") }

  def as_json(options)
    excluded_fields = [:created_at, :updated_at, :id]
    super(options.merge(except: excluded_fields)).merge(
      {
        release_date: self.release_date.to_s(:db)
      })
  end
end
