class UpdatePostcodeprimaryKey < ActiveRecord::Migration[7.0]
  def change
    remove_column :postcodes, :id
    execute "ALTER TABLE postcodes ADD PRIMARY KEY (postcode)"
  end
end
