class Educacao < ActiveRecord::Base

  # By default, use the GEOS implementation for spatial columns.
  self.rgeo_factory_generator = RGeo::Geos.factory_generator

  # But use a geographic implementation for the :lonlat column.
  set_rgeo_factory_for_column(:lonlat, RGeo::Geographic.spherical_factory(:srid => 4326))
  
  attr_accessible :nome, :email, :contato, :the_geom       

  validates :nome, :email, :contato, presence: true


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
