class Job < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  validates_uniqueness_of :user_id, scope: :date

end
