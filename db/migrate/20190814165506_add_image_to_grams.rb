class AddImageToGrams < ActiveRecord::Migration[5.2]
  def change
    add_column :grams, :image, :string
  end
end
