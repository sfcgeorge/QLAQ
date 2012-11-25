class AddBirthdayToRefineryUser < ActiveRecord::Migration
  def change
    add_column :refinery_users, :birthday, :date
  end
end
