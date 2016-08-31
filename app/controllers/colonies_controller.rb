class ColoniesController < ApplicationController

    def look_up_root

    end

    def look_up_query
        query_type = params[:query_type]
        origin = params[:origin]
        query_parameter = params[:query_parameter]

        if query_type == 'distance_limit'
            origin_data = Colony.geocode(origin)
            query_parameter = query_parameter.to_f
            matches = Colony.within(query_parameter,origin: origin)
            return_matches = matches.map {|colony| {id:colony.id, caretaker_name:colony.primary_first_name.to_s+" "+colony.primary_last_name.to_s, email:colony.primary_email, phone:colony.primary_phone, year_active:colony.year_active, full_address:colony.detailed_prior_mapped_address,lat:colony.lat,lng:colony.lng, distance: colony.distance_to(origin) }}
        elsif query_type == 'closest_colonies'
            origin_data = Colony.geocode(origin)
            query_parameter = query_parameter.to_i
            matches = Colony.by_distance(origin:origin).limit(query_parameter)
            return_matches = matches.map {|colony| {id:colony.id, caretaker_name:colony.primary_first_name.to_s+" "+colony.primary_last_name.to_s, email:colony.primary_email, phone:colony.primary_phone, year_active:colony.year_active, full_address:colony.detailed_prior_mapped_address,lat:colony.lat,lng:colony.lng, distance: colony.distance_to(origin) }}
        else
            matches = Colony.where("map_street_number is not null and map_street_name is not null and map_city_name is not null and map_postal_code is not null")
            return_matches = matches.map {|colony| {id:colony.id, caretaker_name:colony.primary_first_name.to_s+" "+colony.primary_last_name.to_s, email:colony.primary_email, phone:colony.primary_phone, year_active:colony.year_active, full_address:colony.detailed_prior_mapped_address,lat:colony.lat,lng:colony.lng}}
        end

        respond_to do |format|
          format.json {
            render json: origin_data.blank? ? {status:'success',data:return_matches}.to_json : {status:'success', origin:{address:origin, lat:origin_data.lat, lng:origin_data.lng},data:return_matches}.to_json
          } 
        end

    end

end
