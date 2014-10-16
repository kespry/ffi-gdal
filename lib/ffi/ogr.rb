require 'ffi'
require_relative 'gdal'

require_relative 'cpl/conv_h'
require_relative 'cpl/minixml_h'
require_relative 'ogr/core_h'
require_relative 'ogr/api_h'

# All of these depend on the above
require_relative 'ogr/srs_api_h'
require_relative 'ogr/featurestyle_h'
require_relative 'ogr/geocoding_h'