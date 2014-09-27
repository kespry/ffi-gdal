require_relative '../ffi/gdal'


module GDAL
  module ColorTables
    module RGB
      def reds
        0.upto(color_entry_count - 1).map do |i|
          color_entry(i)[:c1]
        end
      end

      def greens
        0.upto(color_entry_count - 1).map do |i|
          color_entry(i)[:c2]
        end
      end

      def blues
        0.upto(color_entry_count - 1).map do |i|
          color_entry(i)[:c3]
        end
      end

      def alphas
        0.upto(color_entry_count - 1).map do |i|
          color_entry(i)[:c4]
        end
      end
    end

    module Gray
      def grayscale
        0.upto(color_entry_count - 1).map do |i|
          color_entry(i)[:c1]
        end
      end
    end

    module CMYK
      def cyans
        0.upto(color_entry_count - 1).map do |i|
          color_entry(i)[:c1]
        end
      end

      def magentas
        0.upto(color_entry_count - 1).map do |i|
          color_entry(i)[:c2]
        end
      end

      def yellows
        0.upto(color_entry_count - 1).map do |i|
          color_entry(i)[:c3]
        end
      end

      def blacks
        0.upto(color_entry_count - 1).map do |i|
          color_entry(i)[:c4]
        end
      end
    end

    module HLS
      def hues
        0.upto(color_entry_count - 1).map do |i|
          color_entry(i)[:c1]
        end
      end

      def lightnesses
        0.upto(color_entry_count - 1).map do |i|
          color_entry(i)[:c2]
        end
      end

      def saturations
        0.upto(color_entry_count - 1).map do |i|
          color_entry(i)[:c3]
        end
      end
    end
  end

  class ColorTable
    include FFI::GDAL

    def initialize(gdal_raster_band, color_table_pointer: nil)
      @gdal_raster_band = if gdal_raster_band.is_a? GDAL::RasterBand
        gdal_raster_band.c_pointer
      else
        gdal_raster_band
      end

      @gdal_color_table = if color_table_pointer
        color_table_pointer
      else
        GDALGetRasterColorTable(@gdal_raster_band)
      end

      unless @gdal_color_table.null?
        case palette_interpretation
        when :GPI_Gray then extend GDAL::ColorTables::Gray
        when :GPI_RGB then extend GDAL::ColorTables::RGB
        when :GPI_CMYK then extend GDAL::ColorTables::CMYK
        when :GPI_HLS then extend GDAL::ColorTables::HLS
        end
      end
    end

    def c_pointer
      @gdal_color_table
    end

    def null?
      @gdal_color_table.null?
    end

    # Usually :GPI_RGB.
    #
    # @return [Symbol] One of FFI::GDAL::GDALPaletteInterp.
    def palette_interpretation
      GDALGetPaletteInterpretation(@gdal_color_table)
    end

    # @return [Fixnum]
    def color_entry_count
      return 0 if null?

      GDALGetColorEntryCount(@gdal_color_table)
    end

    # @param index [Fixnum]
    # @return [FFI::GDAL::GDALColorEntry]
    def color_entry(index)
      return nil if null?

      GDALGetColorEntry(@gdal_color_table, index)
    end

    # @param index [Fixnum]
    # @return [GGI::GDAL::GDALColorEntry]
    def color_entry_as_rgb(index)
      return nil if null?

      entry = GDALColorEntry.new
      GDALGetColorEntryAsRGB(@gdal_color_table, index, entry)

      entry
    end
  end
end
