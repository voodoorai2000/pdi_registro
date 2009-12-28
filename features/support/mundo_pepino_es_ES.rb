require 'mundo_pepino'
require 'mundo_pepino/es_ES/matchers'
require 'mundo_pepino/es_ES/mappings'

MundoPepino.configure do |config|
  config.models_to_clean = [
    # ENTRADA AUTO-GENERADA PARA Orchard
    Orchard, # (TODO: quitar la coma final si es el primer modelo)

    # MODELOS PARA LIMPIAR antes de cada escenario,
    # por ejemplo:
    # Orchard, Terrace, Crop...
  ]

  config.model_mappings = {
  # MAPEO DE MODELO AUTO-GENERADO (Orchard)
  /^huertos?$/i   => Orchard, # (TODO: validar RegExp para forma plural y coma final)
  /^region(es)?$/ => Region,
  /^usuarios?$/   => User


    # TRADUCCIÓN DE MODELOS AQUÍ, por ejemplo:
    # /^huert[oa]s?/i            => Orchard,
    # /^bancal(es)?$/i           => Terrace,
    # /^cultivos?$/i             => Crop...
  }

  config.field_mappings = {
  # MAPEO DE CAMPO AUTO-GENERADO (used)
  /^usados?$/i => :used, # (TODO: validar RegExp para forma plural y coma final)

  # MAPEO DE CAMPO AUTO-GENERADO (latitude)
  /^latitud(es)?$/i => :latitude, # (TODO: validar RegExp para forma plural y coma final)

  # MAPEO DE CAMPO AUTO-GENERADO (longitude)
  /^longitud(es)?$/i => :longitude, # (TODO: validar RegExp para forma plural y coma final)

  # MAPEO DE CAMPO AUTO-GENERADO (area)
  /^áreas?$/i => :area, # (TODO: validar RegExp para forma plural y coma final)

  # MAPEO DE CAMPO AUTO-GENERADO (name)
  /^nombres?$/i => :name, # (TODO: validar RegExp para forma plural y coma final)

    # TRADUCCIÓN DE CAMPOS AQUÍ:
    # /^[Ááa]reas?$/i    => 'area',
    # /^color(es)?$/i   => 'color',
    # /^latitud(es)?$/i => 'latitude',
    # /^longitud(es)?/i => 'length'
    #
    # TRADUCCIÓN ESPECÍFICA PARA UN MODELO
    # /^Orchard::longitud(es)?$/   => 'longitude'
  }

  config.url_mappings = {
    # TRADUCCIÓN DE RUTAS/URLS AQUÍ
    # Hardcoded
    #/^la página de registro/i => '/users/new',
    # From app routes:
    #/^la página de inicio de sesión/i => lambda {
    #  MundoPepino.world.new_session_path
    #},
    # And the fancy one: specific resource page
    #/^la página de(?:l| la) (.+) ["'](.+)['"]$/ => lambda {|captures|
    #  if model = captures[0].to_model
    #    MundoPepino.world.send "#{model.name.underscore}_path", model.find_by_name(captures[1])
    #  end
    #}
    /^la p[áa]gina de editar mi perfil$/ => "/account/edit",
    /^la p[áa]gina de mi perfil$/ => "/account/"
  }

end


Before do
  MundoPepino.clean_models
end

#module MundoPepino
#  # Helpers específicos de nuestras features que necesiten estar 
#  # "incluidos" (no extendidos), por ejemplo:
#  include FixtureReplacement # probado!
#  include Machinist # probado!
#end
# # Si utilizas factory_girl # probado!
require 'factory_girl'
# #Definición de las factorias equivalente a example_data.rb en fixture_replacement
require File.expand_path(File.dirname(__FILE__) + '../../../db/factories')
