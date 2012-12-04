class AddSexualityToRefineryUser < ActiveRecord::Migration
  def change
    add_column :refinery_users, :sexuality, :text
  end
end
