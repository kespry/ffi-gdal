module FFI
  module GDAL
    extend ::FFI::Library
    ffi_lib 'gdal'

    #-------------------------------------------------------------------------
    # Enums
    #-------------------------------------------------------------------------
    GDALResampleAlg = enum :GRA_NearestNeighbor,
      :GRA_Bilinear,
      :GRA_Cubic,
      :GRA_CubicSpline,
      :GRA_Lanczos,
      :GRA_Average,
      :GRA_Mode

    #-------------------------------------------------------------------------
    # Typedefs
    #-------------------------------------------------------------------------
    callback :GDALMaskFunc,
    [
      :pointer, :int, GDALDataType,
      :int, :int, :int, :int,
      :pointer, :int, :pointer
    ],
    :int

    typedef :pointer, :GDALWarpOperationH

    #-------------------------------------------------------------------------
    # Functions
    #-------------------------------------------------------------------------
    attach_function :GDALAutoCreateWarpedVRT,
      [:GDALDatasetH, :string, :string, GDALResampleAlg, :double, :pointer],
      :GDALDatasetH

    attach_function :GDALChunkAndWarpImage,
      %i[GDALWarpOperationH int int int int],
      CPLErr

    attach_function :GDALChunkAndWarpMulti,
      %i[GDALWarpOperationH int int int int],
      CPLErr

    attach_function :GDALCreateWarpedVRT,
      [:GDALDatasetH, :int, :int, :pointer, GDALWarpOptions.ptr],
      :GDALDatasetH

    attach_function :GDALCreateWarpOperation,
      [GDALWarpOptions.ptr],
      :GDALWarpOperationH

    attach_function :GDALInitializeWarpedVRT,
      [:GDALDatasetH, GDALWarpOptions.ptr],
      CPLErr

    attach_function :GDALReprojectImage,
    [
      :GDALDatasetH, :string, :GDALDatasetH, :string,
      GDALResampleAlg, :double, :double,
      :GDALProgressFunc, :pointer, GDALWarpOptions.ptr
    ],
    CPLErr

    attach_function :GDALWarpRegion,
    %i[GDALWarpOperationH int int int int int int int int],
    CPLErr

    attach_function :GDALWarpRegionToBuffer,
    [
      :GDALWarpOperationH, :int, :int, :int, :int,
      :buffer_inout,
      GDALDataType, :int, :int, :int, :int
    ],
    CPLErr
    end
  end
