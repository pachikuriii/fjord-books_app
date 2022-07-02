class AddpostcodeTousers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :postcode, :integer, limit: 7
  end
end
