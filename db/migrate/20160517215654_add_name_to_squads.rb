class AddNameToSquads < ActiveRecord::Migration
  def change
    add_column :squads, :name, :string
  end
end
