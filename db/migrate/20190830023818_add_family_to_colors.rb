class AddFamilyToColors < ActiveRecord::Migration[6.0]
  def change
    add_column :colors, :family, :string
  end
end
