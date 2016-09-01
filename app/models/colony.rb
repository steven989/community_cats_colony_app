class Colony < ActiveRecord::Base

  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

    def detailed_prior_mapped_address
        "#{map_street_number} #{map_street_name}, #{map_city_name}, #{map_postal_code}"
    end

end
