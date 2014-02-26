class CreateEducacaos < ActiveRecord::Migration
  def change
    create_table :educacaos do |t|
      t.string :nome
      t.string :email
      t.string :contato
      t.point :the_geom, :geographic => true, :srid => 4326

      t.timestamps
    end
  end
end
