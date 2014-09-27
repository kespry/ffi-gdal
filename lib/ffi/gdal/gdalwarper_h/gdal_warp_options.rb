require 'ffi'

module FFI
  module GDAL
    class GDALWarpOptions < FFI::Struct
      layout :warp_options, :pointer,     # array of strings
        :warp_memory_limit, :double,
        :resample_alg, GDALResampleAlg,
        :working_data_type, GDALDataType,
        :source_dataset, :GDALDatasetH,
        :destination_dataset, :GDALDatasetH,
        :band_count, :int,
        :source_bands, :pointer,          # to an int
        :destination_bands, :pointer,     # to an int
        :source_alpha_band, :int,
        :destination_alpha_band, :int,
        :source_no_data_real, :pointer,   # to a double
        :source_no_data_imaginary, :pointer,    # to a double
        :destination_no_data_real, :pointer,   # to a double
        :destination_no_data_imaginary, :pointer,    # to a double
        :progress, :GDALProgressFunc,
        :progress_arg, :pointer,                      # to a void
        :transformer, :GDALTransformerFunc,
        :transformer_arg, :pointer,
        :source_per_band_validity_mask_function, :GDALMaskFunc,
        :source_per_band_validity_mask_function_arg, :pointer,
        :source_validity_mask_function, :GDALMaskFunc,
        :source_validity_mask_function_arg, :pointer,
        :source_density_mask_function, :GDALMaskFunc,
        :source_density_mask_function_arg, :pointer,
        :destination_density_mask_function, :GDALMaskFunc,
        :destination_density_mask_function_arg, :pointer,
        :destination_validity_mask_function, :GDALMaskFunc,
        :destination_validity_mask_function_arg, :pointer,
        :pre_warp_chunk_processor, :pointer,
        :pre_warp_processor_arg, :pointer,
        :post_warp_chunk_processor, :pointer,
        :post_warp_processor_arg, :pointer,
        :cutline, :pointer,
        :cutline_blend_dist, :double
    end
  end
end
