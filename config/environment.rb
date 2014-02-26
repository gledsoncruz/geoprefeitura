# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Geoprefeitura::Application.initialize!

Time::DATE_FORMATS[:data_br] = "%d/%m/%Y"
Time::DATE_FORMATS[:dia_semana] = "%A"
Time::DATE_FORMATS[:hora] = "%H:%M:%S"

#RGeo::ActiveRecord::GeometryMixin.set_json_generator(:geojson)
#ActiveRecord::Base.include_root_in_json = true


