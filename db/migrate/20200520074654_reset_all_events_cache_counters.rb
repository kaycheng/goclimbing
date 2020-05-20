class ResetAllEventsCacheCounters < ActiveRecord::Migration[6.0]
  def up
    Event.all.each do |event|
      Event.reset_counters(event.id, :participates)
    end 
  end
  def down
  end
end
