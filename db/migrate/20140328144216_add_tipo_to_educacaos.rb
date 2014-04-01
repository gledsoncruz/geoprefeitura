class AddTipoToEducacaos < ActiveRecord::Migration
  def change
    add_column :educacaos, :tipo, :string
  end
end
