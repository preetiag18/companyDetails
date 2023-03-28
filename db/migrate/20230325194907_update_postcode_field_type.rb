class UpdatePostcodeFieldType < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :companies, :postcodes
    change_column(:companies, :postcode, :string)
    change_column(:postcodes, :postcode, :string)
    add_foreign_key :companies, :postcodes, column: :postcode, primary_key: :postcode
  end
end
