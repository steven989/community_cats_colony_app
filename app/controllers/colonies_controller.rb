class ColoniesController < ApplicationController
    before_action :require_login

    def look_up_root
        #no variables needed here
    end

    def new
        @colony = Colony.new
        @action = "new"
        @route = create_colony_path
        @method = "post"
        respond_to do |format|
          format.html {
            render partial: 'view'
          }      
        end
    end

    def create
        new_address = params[:colony][:colony_street_address]

        begin
            geocode_object = Colony.geocode(new_address)
        rescue => error
            status = 'fail'
            message = error.message
        else
            if geocode_object.success
                if geocode_object.accuracy >= 5
                    colony = Colony.new(admin_update_params)
                    if colony.save
                        if colony.update_attributes(map_street_number:geocode_object.street_number,map_street_name:geocode_object.street_name,map_city_name:geocode_object.city,map_postal_code:geocode_object.zip,batchgeo_address: geocode_object.formatted_address,lat: geocode_object.lat,lng: geocode_object.lng)
                            if params[:colony][:year_active].blank?
                                colony.update_attributes(year_active:colony.created_at.year)
                            end
                            status = 'success'
                            message = "Colony created"
                        else
                            status = 'fail'
                            message = colony.errors.full_messages.join(", ")
                        end
                    else 
                        status = 'fail'
                        message = colony.errors.full_messages.join(", ")
                    end
                else
                    status = 'fail'
                    message = "The address provided is not specific enough"
                end
            else
                status = 'fail'
                message = "The new address could not be coded"
            end
        end

        respond_to do |format|
          format.json {
            render json: {status:status,message:message}.to_json
          } 
        end
    end

    def edit
        @colony = Colony.find(params[:id])
        @action = "edit"
        @route = admin_update_colony_path(@colony)
        @method = "put"
        respond_to do |format|
          format.html {
            render partial: 'view'
          }      
        end
    end

    def destroy
        colony = Colony.find(params[:id])
        colony.destroy
        redirect_to look_up_colonies_path
    end

    def admin_update
        colony = Colony.find(params[:id])
        current_address = colony.colony_street_address
        new_address = params[:colony][:colony_street_address]
        need_to_geocode = current_address != new_address
        begin
            geocode_object = Colony.geocode(new_address) if need_to_geocode
        rescue => error
            status = 'fail'
            message = error.message
        else
            if colony
                if need_to_geocode
                    if geocode_object.success
                        if geocode_object.accuracy >= 5
                            if colony.update_attributes(admin_update_params)
                                if colony.update_attributes(map_street_number:geocode_object.street_number,map_street_name:geocode_object.street_name,map_city_name:geocode_object.city,map_postal_code:geocode_object.zip,batchgeo_address: geocode_object.formatted_address,lat: geocode_object.lat,lng: geocode_object.lng)
                                    status = 'success'
                                    message = "Colony updated"
                                else
                                    status = 'fail'
                                    message = colony.errors.full_messages.join(", ")
                                end
                            else 
                                status = 'fail'
                                message = colony.errors.full_messages.join(", ")
                            end
                        else
                            status = 'fail'
                            message = "The address provided is not specific enough"
                        end
                    else
                        status = 'fail'
                        message = "The new address could not be coded"
                    end
                else
                    if colony.update_attributes(admin_update_params)
                        status = 'success'
                        message = "Colony updated"
                    else 
                        status = 'fail'
                        message = colony.errors.full_messages.join(", ")
                    end
                end
            else 
                status = 'fail'
                message = "Colony could not be found"
            end
        end

        respond_to do |format|
          format.json {
            render json: {status:status,message:message}.to_json
          } 
        end
    end

    def look_up_query
        query_type = params[:query_type]
        origin = params[:origin]
        query_parameter = params[:query_parameter]

        begin
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
        rescue => error
            status = "fail"
            message = error.message
        else
            status = "success"
        end

        respond_to do |format|
          format.json {
            render json: origin_data.blank? ? {status:status,message:message,data:return_matches}.to_json : {status:status, message:message, origin:{address:origin, lat:origin_data.lat, lng:origin_data.lng},data:return_matches}.to_json
          } 
        end

    end

    private

    def admin_update_params
        params.require(:colony).permit(:colony_street_address,:how_to_find_colony_at_address,:primary_email,:primary_first_name,:primary_last_name,:primary_phone,:primary_cell_or_work_number,:primary_alternate_email,:secondary_first_name,:secondary_last_name,:secondary_phone,:secondary_cell,:secondary_email,:secondary_alternate_email,:year_active,:colony_name,:colony_city,:colony_intersection_first_street,:colony_intersection_second_street,:colony_ward,:colony_setting,:is_colony_registered_with_another_organization,:registered_with_which_organization,:member_of_org_or_rescue_org,:which_organization,:attended_feral_colony_workshop,:which_org_or_rescue_org,:have_you_attended_workshop_on_feral_cat_management,:do_you_know_previous_caretaker,:male_count,:female_count,:undetermined_count,:kitten_count,:male_deaths_natural,:male_deaths_suspicious,:male_deaths_euthanasia,:male_deaths_predator,:male_deaths_car_or_accident,:female_deaths_natural,:female_deaths_suspicious,:female_deaths_euthanasia,:female_deaths_predator,:female_deaths__car_or_accident,:undetermined_deaths_natural,:undetermined_deaths_suspicious,:undetermined_deaths_euthanasia,:undetermined_deaths_predator,:undetermined_deaths_car_or_accident,:kitten_deaths_natural,:kitten_deaths_suspicious,:kitten_deaths_euthanasia,:kitten_deaths_predator,:kitten_deaths_car_or_accident,:male_disappearances,:female_disappearances,:undetermined_disappearances,:kitten_disappearances,:do_you_have_problems_with_predators,:coyote_problems,:racoon_problems,:other_predator_problems,:number_of_male_cats_added_to_colony,:number_of_female_cats_added_to_colony,:number_of_undetermined_cats_added_to_colony,:were_tnrd_cats_returned_to_colony,:were_tnrd_cats_documentedphotographed,:spayed,:neutered,:early_age_spaying,:early_age_neutering,:where_were_cats_sn,:why_did_you_use_the_sn_services_you_did,:how_long_to_get_sn_appointment,:most_cats_sn_at_one_time,:how_did_you_get_to_clinic,:did_you_have_other_drivers,:where_did_cats_recover,:how_did_cats_recover,:number_days_of_recovery_female,:number_days_of_recovery_kittens,:were_cats_eartipped,:were_cats_vaccinated,:were_cats_microchipped,:male_returned_to_colony,:female_returned_to_colony,:kittens_returned_to_colony,:male_fostered_adopted,:female_fostered_adopted,:kittens_fostered_adopted,:trapping_resources,:number_of_owned_traps,:number_of_borrowed_traps,:borrowed_traps_from_where,:borrowed_carriers_for_what_purpose,:did_you_have_help_trapping,:how_many_people_helpd_you_trap,:trappers_came_from_where,:total_sn_expenses_to_date,:expenses_to_date_for_medical_care_or_emergencies,:colony_expenses_per_week,:received_money_or_free_food_to_help,:issues_you_have_with_neighbours_etc,:free_roaming_cats_in_area,:owned_but_unaltered_allowed_to_roam,:are_cats_abandoned_near_your_colony,:number_of_cats_abandoned_per_year_near_colony,:did_you_try_to_educate_neighbours_about_tnr,:neighbourhood_advised_re_tnr_occuring,:did_you_advise_others_not_to_feed_cats,:did_you_advise_neighbourhood_how_successful_tnr_is,:how_did_you_advise_neighbours_re_tnr_success,:cats_threatened_poisoned_or_killed,:you_or_family_been_threatenedharmed,:home_or_property_vandalized_due_to_cats,:police_bylaw_enforcement_or_animal_services_contacted,:what_was_the_issue_for_police_etc,:was_issue_resolved,:is_local_govmt_feral_friendly,:local_govmt_supports_tnr,:how_does_local_govmt_support_tnr,:do_you_have_help_caring_for_colony,:how_often_do_others_help,:how_do_others_help_you,:how_often_do_you_feed_the_colony,:what_time_of_day_do_you_feed_colony,:feed_in_dishes,:fed_open_station,:fed_building,:feeding_station,:fed_covered_station,:feed_in_dishes_on_ground,:food_directly_on_ground,:feed_in_other_circumstances,:do_you_feed_wet_food,:do_you_feed_dry_food,:do_you_feed_supplementsvitamins,:do_you_feed_naturopathic_or_other,:how_many_shelters_are_in_place,:how_many_styrofoam_shelters,:how_many_plastic_lined_with_styrofoam,:how_many_wooden_shelters,:how_many_cardboard_shelters,:how_many_other_shelters_in_place,:do_you_change_straw_in_spring_and_fall,:do_you_have_difficulty_finding_straw,:overall_condition_of_colony,:disease_or_ongoing_health_concerns_in_colony,:describe_ongoing_cat_health_concerns_briefly,:are_you_a_member_of_toronto_feral_cat_yahoo_group,:are_you_a_member_of_toronto_feral_cat_facebook_group,:are_you_a_member_of_toronto_feral_cat_other_group,:interested_in_seminar_on_caretaker_burnout,:interested_in_seminar_on_situational_awareness,:interested_in_self_defence,:any_suggestions_for_other_seminars,:what_support_would_help_you_with_your_colony,:what_is_your_greatest_challenge,:would_you_be_interested_in_helping_other_colony_caretakers,:secondary_member_of_org_or_rescue_org,:number_days_of_recovery_male,:neighbourhood_statisfaction_to_cats,:neighbourhood_satisfaction_to_you_and_tnr_efforts,:issues_found)
    end


end
