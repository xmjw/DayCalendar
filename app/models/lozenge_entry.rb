class LozengeEntry < ActiveRecord::Base
  attr_accessible :bo, :color, :day, :entry_id, :lo, :ro, :slot, :to
  belongs_to :entry
end
