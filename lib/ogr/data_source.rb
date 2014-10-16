require 'uri'
require 'json'
require_relative '../ffi/gdal'
require_relative '../ffi/ogr'
require_relative 'data_source_extensions'
require_relative 'exceptions'
require_relative 'layer'
require_relative 'style_table'


module OGR
  class DataSource
    include GDAL::MajorObject
    include GDAL::Logger
    include DataSourceExtensions

    # @param path [String] Path/URL to the file to open.
    # @param access_flag [String] 'r' for read, 'w', for write.
    # @return [OGR::DataSource]
    def self.open(path, access_flag = 'r')
      uri = URI.parse(path)
      file_path = uri.scheme.nil? ? ::File.expand_path(path) : path

      pointer = FFI::GDAL.OGROpen(file_path, OGR._boolean_access_flag(access_flag), nil)
      raise OGR::OpenFailure.new(file_path) if pointer.null?

      new(pointer)
    end

    # @param data_source_pointer [FFI::Pointer]
    def initialize(data_source_pointer)
      @data_source_pointer = data_source_pointer
      @file_name = name
      @layers = []

      close_me = -> { destroy }
      ObjectSpace.define_finalizer self, close_me
    end

    def c_pointer
      @data_source_pointer
    end

    def reopen(access_flag)
      if driver.name == 'Memory'
        raise "Can't reopen DataSources that were created and closed using the 'Memory' driver."
      end

      @data_source_pointer = FFI::GDAL.OGROpen(@file_path,
        OGR._boolean_access_flag(access_flag), nil)
    end

    # Closes opened data source and releases allocated resources.
    def destroy
      FFI::GDAL.OGR_DS_Destroy(@data_source_pointer)
    end
    alias_method :close, :destroy

    # Name of the file represented by this object.
    #
    # @return [String]
    def name
      FFI::GDAL.OGR_DS_GetName(@data_source_pointer)
    end

    # @return [OGR::Driver]
    def driver
      return @driver if @driver

      driver_ptr = FFI::GDAL.OGR_DS_GetDriver(@data_source_pointer)
      return nil if driver_ptr.nil?

      @driver = OGR::Driver.new(driver_ptr)
    end

    # @return [Fixnum]
    def layer_count
      FFI::GDAL.OGR_DS_GetLayerCount(@data_source_pointer)
    end

    # @param index [Fixnum] 0-offset index of the layer to retrieve.
    # @return [OGR::Layer]
    def layer(index)
      @layers.fetch(index) do
        layer_pointer = FFI::GDAL.OGR_DS_GetLayer(@data_source_pointer, index)
        return nil if layer_pointer.null?

        l = OGR::Layer.new(layer_pointer)
        @layers.insert(index, l)

        l
      end
    end

    # @param name [String]
    # @return [OGR::Layer]
    def layer_by_name(name)
      layer_pointer = FFI::GDAL.OGR_DS_GetLayerByName(@data_source_pointer, name)
      return nil if layer_pointer.null?

      OGR::Layer.new(layer_pointer)
    end

    # @param name [String] The name for the new layer.
    # @param geometry_type [FFI::GDAL::OGRwkbGeometryType]
    # @param spatial_reference [OGR::SpatialReference] The coordinate system
    #   to use for the new layer or nil if none is available.
    # @return [OGR::Layer]
    def create_layer(name, geometry_type: :wkbUnknown, spatial_reference: nil, **options)
      spatial_ref_ptr = GDAL._pointer(OGR::SpatialReference, spatial_reference)
      options_obj = GDAL::Options.pointer(options)

      layer_ptr = FFI::GDAL.OGR_DS_CreateLayer(@data_source_pointer, name,
        spatial_ref_ptr, geometry_type, options_obj)

      return nil if layer_ptr.null?

      OGR::Layer.new(layer_ptr)
    end

    # @param source_layer [OGR::Layer, FFI::Pointer]
    # @param new_name [String]
    # @param options [Hash]
    # @return [OGR::Layer, nil]
    def copy_layer(source_layer, new_name, **options)
      source_layer_ptr = GDAL._pointer(OGR::Layer, source_layer)
      options_ptr = GDAL::Options.pointer(options)

      layer_ptr = FFI::GDAL.OGR_DS_CopyLayer(@data_source_pointer, source_layer_ptr,
        new_name, options_ptr)
      return nil if layer_ptr.null?

      OGR::Layer.new(layer_ptr)
    end

    # @param index [Fixnum]
    def delete_layer(index)
      ogr_err = FFI::GDAL.OGR_DS_DeleteLayer(@data_source_pointer, index)
    end

    # @param command [String] The SQL to execute.
    # @param spatial_filter [OGR::Geometry, FFI::Pointer]
    # @param dialect [String] Can pass in 'SQLITE' to use that instead of the
    #   default OGRSQL dialect.
    # @return [OGR::Layer, nil]
    # @see http://www.gdal.org/ogr_sql.html
    # TODO: not sure how to handle the call to OGR_DS_ReleaseResultSet here...
    def execute_sql(command, spatial_filter=nil, dialect=nil)
      geometry_ptr = GDAL._pointer(OGR::Geometry, spatial_filter)

      layer_ptr = FFI::GDAL.OGR_DS_ExecuteSQL(@data_source_pointer, command, geometry_ptr,
        dialect)

      return nil if layer_ptr.null?

      OGR::Layer.new(layer_ptr)
    end

    # @return [OGR::StyleTable, nil]
    def style_table
      return @style_table if @style_table

      style_table_ptr = FFI::GDAL.OGR_DS_GetStyleTable(@data_source_pointer)
      return nil if style_table_ptr.null?

      @style_table = OGR::StyleTable.new(style_table_ptr)
    end
  end
end