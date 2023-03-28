class AddForeignKeyConstraint < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :companies, :postcodes, column: :postcode, primary_key: :postcode
  end
end
