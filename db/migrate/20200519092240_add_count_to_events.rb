class AddCountToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :event_count, :interger, default: 0
  end
end
