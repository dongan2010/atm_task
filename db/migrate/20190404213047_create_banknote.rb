class CreateBanknote < ActiveRecord::Migration[5.2]
  def change
    create_table :banknotes do |t|
      t.integer :denomination
    end
  end
end
