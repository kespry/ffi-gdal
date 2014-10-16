require 'RMagick'
require 'tiff'
require 'bundler/setup'
require 'pry'
require 'ffi-gdal'
require 'gdal/utils'

GDAL::Logger.logging_enabled = true

#proj = 'MULTIPOLYGON (((-120.03296317083633 44.226828996384285, -120.03199741570855 44.230616638863914, -120.03305119285443 44.23322276021398, -120.03305439612939 44.23323503554639, -120.03305423080232 44.233247523039175, -120.03305070309673 44.23325975261691, -120.03304394580853 44.233271263913274, -120.03303421330706 44.233281623601044, -120.0330218719597 44.23329044170392, -120.03300738634044 44.23329738627662, -120.03299130174162 44.23330219590042, -120.03297422364709 44.23330468952384, -120.03295679493954 44.23330477327791, -120.0329396717 44.23330244400986, -120.03259652218235 44.23323046886841, -120.03259605091168 44.23323469214073, -120.03259130838445 44.233246748969734, -120.03258339633375 44.23325791928269, -120.03257261443646 44.233267779993575, -120.03255937106756 44.233275957618844, -120.03254416783288 44.23328214242357, -120.03252758057009 44.23328610015274, -120.03251023753826 44.2332876809039, -120.032492795622 44.23328682480475, -120.0324759154512 44.23328356428076, -120.03246023637918 44.23327802282714, -120.03244635226639 44.233270410331386, -120.03229057481504 44.233166296752856, -120.03144275436163 44.23298846700243, -120.03135705202111 44.23542539118272, -120.03135483571377 44.23543806847976, -120.0313491680669 44.2354501823413, -120.0313402724131 44.23546125542315, -120.03132849928409 44.23547085139311, -120.03131431259804 44.235478592124444, -120.03129827137883 44.235484172595754, -120.03128100772805 44.23548737291011, -120.03126320191683 44.23548806696012, -120.03124555558011 44.235486227396926, -120.03122876406881 44.235481926707976, -120.03121348904955 44.23547533436071, -120.03120033243181 44.23546671012462, -120.03118981264993 44.23545639383555, -120.02629194435607 44.229488174527326, -120.0262841759258 44.22947593881562, -120.0262801234077 44.229462813795166, -120.02627996353844 44.22944937186798, -120.0262837032901 44.22943619925734, -120.02629117956641 44.22942387044152, -120.02630206631528 44.22941292309999, -120.02631588874878 44.229403834664076, -120.02650834059244 44.22930162063937, -120.02596466290531 44.22893822933382, -120.02595288197551 44.22892861642798, -120.02594398682248 44.22891752390089, -120.02593832881524 44.2289053899198, -120.02593613145164 44.22889269379079, -120.02593748153026 44.22887993702566, -120.02594232572132 44.2288676235318, -120.02595047267361 44.22885623970722, -120.0259616005729 44.228846235226946, -120.02597526985406 44.22883800528063, -120.0259909405644 44.22883187496161, -120.02600799369236 44.22882808642537, -120.02602575561929 44.228826789324046, -120.02604352472815 44.22882803489487, -120.02606059911827 44.2288317739361, -120.02607630433104 44.22883785875077, -120.02675839864344 44.229168810839475, -120.02688733695234 44.22910032953997, -120.02611125484312 44.228061533840545, -120.02610457348571 44.22805003875662, -120.02610110582951 44.22803783693943, -120.02610098163969 44.228025384999874, -120.02610420556363 44.2280131489091, -120.02611065695699 44.22800158656121, -120.0261200943985 44.22799113063793, -120.02613216472427 44.22798217241707, -120.02614641624366 44.227975047130094, -120.0261623156424 44.22797002141719, -120.02617926794002 44.22796728334896, -120.0261966387548 44.227966935388565, -120.02621377804353 44.22796899055725, -120.02623004442708 44.22797337194719, -120.0262448291917 44.2279799155993, -120.02625757906833 44.22798837663918, -120.02626781693645 44.22799843844071, -120.02754662923428 44.229551257921585, -120.030836241635 44.23114734101261, -120.03136956622194 44.229959117652726, -120.03138391393463 44.22955111324294, -120.03138620312208 44.229538207384174, -120.0313920671636 44.22952589494864, -120.03140126651873 44.229514678887824, -120.03141342540293 44.229505017367465, -120.03142804713777 44.22949730505196, -120.03144453443974 44.229491856982676, -120.03146221381887 44.22948889570851, -120.03148036308987 44.22948854219496, -120.03149824087296 44.229490810882744, -120.03151511687828 44.22949560909792, -120.03153030173767 44.22950274083756, -120.03154317516459 44.22951191477631, -120.0315532112922 44.22952275616695, -120.03156000257852 44.22953482814357, -120.03278854263438 44.22679758476189, -120.03286127379035 44.226512326846944, -120.03286465252121 44.226503048718484, -120.03286991708133 44.22649423317623, -120.03301731535839 44.22629080564284, -120.03302703028369 44.22628013425537, -120.03303948802117 44.22627104306898, -120.03305420051213 44.22626388825138, -120.03307059136289 44.22625895010873, -120.0330880184265 44.22625642210408, -120.03310579896007 44.22625640327766, -120.03312323637284 44.226258894367135, -120.03313964751646 44.22626379777834, -120.03315438944897 44.22627092140904, -120.03316688462326 44.22627998617475, -120.03317664351395 44.22629063694302, -120.03318328379541 44.22630245644617, -120.03318654532022 44.226314981629145, -120.03318630031114 44.22632772179051, -120.0331825583669 44.22634017780693, -120.03296317083633 44.226828996384285)))'

floyd_too_big_wkt = 'MULTIPOLYGON (((-87.55634718933241 31.168633650404765, -87.552227316286 31.16870709121005, -87.55234533348232 31.169808696448463, -87.5478606800096 31.1698913163249, -87.54777484932141 31.168679550914895, -87.54380517997858 31.168615290194918, -87.54396611251944 31.16511760526154, -87.55647593536513 31.164906454793982, -87.55634718933241 31.168633650404765)))'
floyd_wkt = 'MULTIPOLYGON (((-87.5530099868775 31.16710573359053,-87.5530099868775 31.165600160261103,-87.55384683609009 31.16710573359053,-87.5530099868775 31.16710573359053)))'
floyd_srid = 4326

harper_path = '/Users/sloveless/Development/projects/ffi-gdal/spec/support/images/Harper/Harper_1058_20140612_NRGB.tif'
harper = GDAL::Dataset.open(harper_path, 'r')

floyd_path = '/Users/sloveless/Development/projects/ffi-gdal/spec/support/images/Floyd/Floyd_1058_20140612_NRGB.tif'
floyd = GDAL::Dataset.open(floyd_path, 'r')

spatial_ref = OGR::SpatialReference.new(floyd.projection)
floyd_geometry = OGR::Geometry.create_from_wkt(floyd_wkt, spatial_ref)

usg_path = '/Users/sloveless/Development/projects/ffi-gdal/spec/support/images/osgeo/geotiff/usgs/c41078a1.tif'
usg = GDAL::Dataset.open(usg_path, 'r')

peter_path = '~/Downloads/ABCTURF_NEWFARM_15-5_2014-09-14.tif'
peter = GDAL::Dataset.open(peter_path, 'r')

world_file_path = "#{__dir__}/spec/support/worldfiles/SR_50M/SR_50M.tif"
world_file = GDAL::GeoTransform.from_world_file(world_file_path, 'tfw')

binding.pry

def extract_ndvi(dataset, destination_path, wkt_geometry)
  nir_band = dataset.raster_band(1)
  red_band = dataset.raster_band(2)
  nir_array = nir_band.to_na
  red_array = red_band.to_na

  # Create an OGR::Geometry from the WKT and convert to dataset's projection.
  wkt_spatial_ref = OGR::SpatialReference.new_from_epsg(4326)
  geometry = OGR::Geometry.create_from_wkt(wkt_geometry,
    wkt_spatial_ref)
  geometry.transform_to!(dataset.spatial_reference)

  # Create the geo_tranform for the geometry-raster, based on the original
  # dataset's geo_transform.
  pixel_extent = geometry.envelope.world_to_pixel(dataset.geo_transform)
  p pixel_extent
  pixel_height = pixel_extent[:x_max]
  pixel_width = pixel_extent[:y_max]

  y_range = pixel_extent[:y_origin]..(pixel_extent[:y_max] - 1)
  x_range = pixel_extent[:x_origin]...(pixel_extent[:x_max] - 1)
  red_clip_array = red_array[x_range, y_range]
  nir_clip_array = nir_array[x_range, y_range]


  #geo = GDAL::GeoTransform.new
  geo = dataset.geo_transform
  #geo.x_origin = dataset.geo_transform.x_origin + pixel_extent[:x_origin]
  geo.x_origin = pixel_extent[:x_origin]
  geo.pixel_width = pixel_extent[:pixel_width]
  geo.x_rotation = 0

  #geo.y_origin = dataset.geo_transform.y_origin + pixel_extent[:y_origin]
  #geo.y_origin = pixel_extent[:y_origin]
  geo.y_origin = pixel_extent[:y_max].abs     # the book shows this--is it right?
  geo.pixel_height = pixel_extent[:pixel_height]
  geo.y_rotation = 0

  # Get pixels for each point of each linear ring in the geometry.
  pixels = case geometry.type
  when :wkbMultiPolygon
    polygon = geometry.geometry_at(0)
    linear_ring = polygon.geometry_at(0)
    #linear_ring.pixels(dataset.geo_transform)
    linear_ring.pixels(geo)
  else
    raise 'bleh'
  end


  # Write the pixels to an array at the size of the new image
  image = Magick::Image.new(pixel_extent[:x_max], pixel_extent[:y_max])
  poly = Magick::Draw.new
  poly.fill('#00ffff')
  poly.polygon(*pixels)
  poly.draw(image)
  image.write('bobo.tif')

  excerpted_image = image.excerpt(pixel_extent[:x_origin], pixel_extent[:y_origin],
    pixel_extent[:pixel_count], pixel_extent[:line_count])
  # rasterized_pixels = excerpted_image.export_pixels(0, 0,
  #   pixel_extent[:pixel_count], pixel_extent[:line_count], 'I')
  rasterized_pixels = image.export_pixels(pixel_extent[:x_origin], pixel_extent[:y_origin],
    pixel_extent[:pixel_count], pixel_extent[:line_count], 'I')
  mask = NArray[rasterized_pixels]
  mask.reshape!(pixel_extent[:pixel_count], pixel_extent[:line_count])
  p mask.to_a.flatten.count { |b| !b.zero? }
  p red_clip_array.to_a.flatten.count { |b| !b.zero? }
  p nir_clip_array.to_a.flatten.count { |b| !b.zero? }


  i = 0
  red_clip_array.each do |_|
    if mask[i] == 65535
      red_clip_array[i] = 1.0
    end

    i += 1
  end

  i = 0
  nir_clip_array.each do |_|
    if mask[i] == 65535
      nir_clip_array[i] = 1.0
    end

    i += 1
  end

  p mask.flatten.to_a.count { |b| !b.zero? }
  p red_clip_array.to_a.flatten.count { |b| !b.zero? }
  p nir_clip_array.to_a.flatten.count { |b| !b.zero? }

  binding.pry
  #ndvi_array = 1.0 * (nir_array - red_array) / nir_array + red_array + 1.0
  ndvi_array = 1.0 * (nir_clip_array - red_clip_array) / (nir_clip_array + red_clip_array) + 1.0
  #ndvi_array = (nir_clip_array - red_clip_array) / (nir_clip_array + red_clip_array)

  driver = GDAL::Driver.by_name('GTiff')
  ndvi_dataset = driver.create_dataset('ndvi.tif', pixel_extent[:x_max], pixel_extent[:y_max]) do |ndvi|
    ndvi.projection = dataset.projection
    ndvi.geo_transform = geo

    ndvi_band = ndvi.raster_band(1)
    # tmp_band.write_array(mask, x_offset: pixel_extent[:x_origin].abs,
    #   y_offset: pixel_extent[:y_origin].abs, data_type: :GDT_Float32)
    #ndvi_band.write_array(ndvi_array, data_type: :GDT_Float32)
    ndvi_band.write_array(ndvi_array)
    #ndvi_band.no_data_value = -9999
  end

  ndvi_dataset.close

  # Create new dataset from the geometry
  #tmp_dataset.rasterize_geometries!(1, linear_ring, 1000)

  #binding.pry
end


#floyd.image_warp('meow.tif', 'GTiff', 1, cutline: floyd_geometry )
#extract_ndvi(floyd, 'ndvi.tif', floyd_wkt)

def warp_to_geometry(dataset, wkt_geometry)

  # Create an OGR::Geometry from the WKT and convert to dataset's projection.
  wkt_spatial_ref = OGR::SpatialReference.new_from_epsg(4326)
  geometry = OGR::Geometry.create_from_wkt(wkt_geometry, wkt_spatial_ref)
  geometry.transform_to!(dataset.spatial_reference)

  binding.pry
  # Create a .shp from the geometry
  shape = geometry.to_vector('geom.shp', 'ESRI Shapefile',
    spatial_reference: dataset.spatial_reference)
  shape.close
end

#warp_to_geometry(floyd, floyd_wkt)