class Task < ActiveRecord::Base
  has_many :jobs
  after_initialize :default_values

  validates :todo, presence: true, allow_blank: false
  validates_uniqueness_of :todo, scope: :date

  def default_values
    self.need ||= 0
    self.people ||= 0
  end

end
