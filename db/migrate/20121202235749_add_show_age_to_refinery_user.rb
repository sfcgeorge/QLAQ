class AddShowAgeToRefineryUser < ActiveRecord::Migration
  def change
    add_column :refinery_users, :show_age, :boolean
  end
end
