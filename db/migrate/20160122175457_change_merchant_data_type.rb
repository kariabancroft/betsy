class ChangeMerchantDataType < ActiveRecord::Migration
  def change
    change_column :merchants, :zip, :integer
  end
end
