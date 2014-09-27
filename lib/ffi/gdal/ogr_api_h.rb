require 'ffi'

module FFI
  module GDAL
    extend FFI::Library
    ffi_lib 'gdal'

    #------------------------------------------------------------------------
    # Typedefs
    #------------------------------------------------------------------------
    typedef :pointer, :OGRCoordinateTransformationH
    typedef :pointer, :OGRDataSourceH
    typedef :pointer, :OGRFeatureH
    typedef :pointer, :OGRFeatureDefnH
    typedef :pointer, :OGRFieldDefnH
    typedef :pointer, :OGRGeomFieldDefnH
    typedef :pointer, :OGRGeometryH
    typedef :pointer, :OGRLayerH
    typedef :pointer, :OGRSFDriverH
    typedef :pointer, :OGRSpatialReferenceH
    typedef :pointer, :OGRStyleMgrH
    typedef :pointer, :OGRStyleTableH
    typedef :pointer, :OGRStyleToolH

    #------------------------------------------------------------------------
    # Functions
    #------------------------------------------------------------------------
    attach_function :OGR_DS_GetLayerCount, [:OGRDataSourceH], :int
  end
end
