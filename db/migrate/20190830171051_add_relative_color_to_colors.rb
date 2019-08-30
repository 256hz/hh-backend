class AddRelativeColorToColors < ActiveRecord::Migration[6.0]
  def change
    add_column :colors, :relative_color, :string
  end
end
