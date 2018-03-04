class AddPanToThirdParty < ActiveRecord::Migration[5.1]
  def change
    add_column :third_parties, :pan, :string
  end
end
