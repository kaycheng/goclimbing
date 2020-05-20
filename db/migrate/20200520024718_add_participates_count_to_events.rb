class AddParticipatesCountToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :participates_count, :integer, default: 0
  end
end
