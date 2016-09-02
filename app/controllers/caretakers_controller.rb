class CaretakersController < ApplicationController
    before_action :require_login, except: [:lookup_colony, :query, :email_admin]

    def lookup_colony
        seed = rand(0...100)
        begin 
            search_result = Unsplash::Photo.search("cats", page=1, per_page = 100)[seed]
        rescue => error
          @background_photo = nil
        else
          search_result.blank? ? @background_photo = nil : @background_photo = search_result.urls["small"]
        end
    end

    def query
        origin = params[:origin]

        if !origin.blank?
            begin
                closest_colony = Colony.closest(origin:origin)[0]
                distance_from_origin = closest_colony.distance_to(origin)
                wider_range_to_search = Colony.search_wider_range(distance_from_origin)
                number_of_colonies_in_wider_range = Colony.within(wider_range_to_search,origin: origin).length
            rescue => error
                status = "fail"
                status_message = error.message
            else
                status = "success"
                status_message = "Lookup successful"
                distance_message = case 
                                        when distance_from_origin <= 0.5
                                            "The closest colony is <b>less than 500m</b> away. "
                                        when distance_from_origin > 0.5 && distance_from_origin <= 1
                                            "The closest colony is <b>less than 1km</b> away. "
                                        when distance_from_origin > 1
                                            "The closest colony is about <b>#{distance_from_origin.round(1)}km</b> away. "
                                    end
                colony_number_message = number_of_colonies_in_wider_range - 1 == 0 ? "" : "There are <b>#{number_of_colonies_in_wider_range - 1} additionl colonies within #{ wider_range_to_search == wider_range_to_search.to_i ? wider_range_to_search.to_i : wider_range_to_search}km</b> from the address entered."
            end
        else
            status = "fail"
            status_message = "Search address field cannot be empty."
        end

        respond_to do |format|
          format.json {
            render json: {status:status,messages:{status_message:status_message,distance_message:distance_message,colony_number_message:colony_number_message}}.to_json
          } 
        end
    end

    def email_admin
        email = params[:email]
        message = params[:message]

        if !email.blank?
            if EmailValidator.valid?(email)
                begin
                    GeneralMailer.colony_connect(email,message).deliver
                rescue => error
                    status = "fail"
                    message = error.message
                else
                    status = "success"
                    message = "Email sent. We will get back to you as soon as possible."
                end
            else
                status = "fail"
                message = "Please enter a valid email address"                    
            end
        else
            status = "fail"
            message = "Please enter an email address"
        end

        respond_to do |format|
          format.json {
            render json: {status:status,message:message}.to_json
          } 
        end

    end

    def new_colony
        
    end

    def register_colony
        
    end

    def manage_colony
        
    end

    def edit_colony
        
    end

    def update_colony
        
    end

    def change_email

    end

    def change_password

    end

end
