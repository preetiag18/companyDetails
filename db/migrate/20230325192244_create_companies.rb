class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :business_id
      t.string :name
      t.integer :postcode
      t.string :details_uri

      t.timestamps
    end
  end
end
