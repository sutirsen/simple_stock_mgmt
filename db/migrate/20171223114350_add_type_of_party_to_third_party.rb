class AddTypeOfPartyToThirdParty < ActiveRecord::Migration[5.1]
  def change
    add_column :third_parties, :type_of_party, :integer
  end
end
