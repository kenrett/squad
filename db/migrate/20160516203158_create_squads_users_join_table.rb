class CreateSquadsUsersJoinTable < ActiveRecord::Migration
  def self.up
    create_table :squads_users, :id => false do |t|
      t.integer :user_id
      t.integer :squad_id
    end

    add_index :squads_users, [:user_id, :squad_id]
  end

  def self.down
    drop_table :squads_users
  end
end
