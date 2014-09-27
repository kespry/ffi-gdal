require 'ffi'

module FFI
  module GDAL
    #---------------------------------------------------------------------------
    # typedefs
    #---------------------------------------------------------------------------
    typedef :int, :GInt32
    typedef :uint, :GUInt32
    typedef :short, :GInt16
    typedef :ushort, :GUInt16
    typedef :uchar, :GByte
    typedef :uint, :GBool
    typedef :long_long, :GIntBig
    typedef :ulong_long, :GUIntBig
  end
end
