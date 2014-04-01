class AddDiretorToEducacaos < ActiveRecord::Migration
  def change
    add_column :educacaos, :diretor, :string
  end
end
