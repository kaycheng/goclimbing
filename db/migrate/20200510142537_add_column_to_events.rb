class AddColumnToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :status, :string
  end
end
