require 'json'

module OGR
  module FeatureExtensions

    # @return [Array<OGR::Field>]
    def fields
      0.upto(field_count - 1).map do |i|
        field(i)
      end
    end

    # @return [Hash]
    def as_json
      {
        definition: definition,
        fid: fid,
        field_count: field_count,
        fields: fields.map(&:as_json),
        geometry: geometry.as_json,
        geometry_field_count: geometry_field_count,
        style_string: style_string
      }
    end

    # @return [String]
    def to_json
      as_json.to_json
    end
  end
end