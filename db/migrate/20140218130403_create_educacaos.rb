class CreateEducacaos < ActiveRecord::Migration
  def change
    create_table :educacaos do |t|
      t.string :nome, limit: 80, null: false
      t.string :email, limit: 80, null: false
      t.string :contato, limit: 16, null: false
      t.point :the_geom, :geographic => true, :srid => 4326

      t.timestamps
    end
  end
end
