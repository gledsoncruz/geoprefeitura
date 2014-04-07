class Educacao < ActiveRecord::Base

  #before_save :uppercase_fields
  before_save {
    |edu| edu.email = email.upcase
          edu.nome  = nome.upcase
          edu.contato = contato.upcase
          edu.diretor = diretor.upcase
  }

  # By default, use the GEOS implementation for spatial columns.
  self.rgeo_factory_generator = RGeo::Geos.factory_generator

  # But use a geographic implementation for the :lonlat column.
  set_rgeo_factory_for_column(:lonlat, RGeo::Geographic.spherical_factory(:srid => 4326))

  attr_accessible :nome, :email, :contato, :the_geom, :tipo, :diretor

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :nome, :diretor, :tipo, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, presence: true
  validates :contato, length: { minimum: 15 }

  TIPO = ['CRECHE MUNICIPAL', 'ESCOLA ESPECIALIZADA', 'FEVRE', 'JARDIM DE INFANCIA', 'ESCOLA MUNICIPAL', 'SECRETARIA DE EDUCACAO']

def self.search(search)
  if search
    find(:all, :conditions => ['nome LIKE ?', "%#{search.upcase}%"])
  else
    find(:all)
  end
end

   	module RGeo
	   module Feature
	     module Point
	       def as_json(params)
	         ::RGeo::GeoJSON.encode(self)
	       end
	     end
	   end
	 end
end
