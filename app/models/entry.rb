class Entry < ActiveRecord::Base
  attr_accessible :activity_id, :hours, :user_id, :week, :year
  has_many :lozege_entry
end
