class CreateRawMaterials < ActiveRecord::Migration[5.1]
  def change
    create_table :raw_materials do |t|
      t.string :name
      t.text :description
      t.numeric :qty
      t.string :unit

      t.timestamps
    end
  end
end
