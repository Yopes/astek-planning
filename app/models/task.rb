class Task < ActiveRecord::Base
  after_initialize :default_values

  validates :todo, presence: true, allow_blank: false

  def default_values
    self.need ||= 0
    self.people ||= 0
  end

end
