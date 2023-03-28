class UpdateCompaniesPrimaryKey < ActiveRecord::Migration[7.0]
  def change
    remove_column :companies, :id
    execute "ALTER TABLE companies ADD PRIMARY KEY (business_id)"
  end
end
