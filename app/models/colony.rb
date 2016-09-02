class Colony < ActiveRecord::Base

  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

    def detailed_prior_mapped_address
        "#{map_street_number} #{map_street_name}, #{map_city_name}, #{map_postal_code}"
    end

    def self.search_wider_range(distance_to_origin)
        distance_to_origin = distance_to_origin.to_f
        case 
            when distance_to_origin <= 2.67
                4.0
            when distance_to_origin > 2.67 && distance_to_origin <= 10
                before_round = distance_to_origin * (1.5 - (0.5/6)*(distance_to_origin-4))
                (before_round*2).ceil / 2.0
            else
                distance_to_origin
        end
            
    end

end
