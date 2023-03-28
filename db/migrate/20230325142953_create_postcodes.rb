class CreatePostcodes < ActiveRecord::Migration[7.0]
  def change
    create_table :postcodes do |t|
      t.integer :postcode

      t.timestamps
    end
  end
end
