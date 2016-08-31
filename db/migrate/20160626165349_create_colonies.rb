class CreateColonies < ActiveRecord::Migration
  def change
    create_table :colonies do |t|
    t.text :issues_found
    t.string :login_email_address
    t.integer :colony_number
    t.integer :year_active
    t.string :colony_name
    t.string :colony_city
    t.string :colony_street_address
    t.string :colony_intersection_first_street
    t.string :colony_intersection_second_street
    t.string :colony_ward
    t.string :colony_setting
    t.string :batchgeo_address
    t.integer :map_street_number
    t.string :map_street_name
    t.string :map_city_name
    t.string :map_postal_code
    t.boolean :is_colony_registered_with_another_organization
    t.boolean :registered_with_which_organization
    t.string :primary_first_name
    t.string :primary_last_name
    t.string :primary_phone
    t.string :primary_cell_or_work_number
    t.string :primary_email
    t.string :primary_alternate_email
    t.boolean :member_of_org_or_rescue_org
    t.string :which_organization
    t.boolean :attended_feral_colony_workshop
    t.string :secondary_first_name
    t.string :secondary_last_name
    t.string :secondary_phone
    t.string :secondary_cell
    t.string :secondary_email
    t.string :secondary_alternate_email
    t.boolean :member_of_org_or_rescue_org
    t.string :which_org_or_rescue_org
    t.boolean :have_you_attended_workshop_on_feral_cat_management
    t.boolean :do_you_know_previous_caretaker
    t.integer :male_count
    t.integer :female_count
    t.integer :undetermined_count
    t.integer :kitten_count
    t.integer :male_deaths_natural
    t.integer :male_deaths_suspicious
    t.integer :male_deaths_euthanasia
    t.integer :male_deaths_predator
    t.integer :male_deaths_car_or_accident
    t.integer :female_deaths_natural
    t.integer :female_deaths_suspicious
    t.integer :female_deaths_euthanasia
    t.integer :female_deaths_predator
    t.integer :female_deaths__car_or_accident
    t.integer :undetermined_deaths_natural
    t.integer :undetermined_deaths_suspicious
    t.integer :undetermined_deaths_euthanasia
    t.integer :undetermined_deaths_predator
    t.integer :undetermined_deaths_car_or_accident
    t.integer :kitten_deaths_natural
    t.integer :kitten_deaths_suspicious
    t.integer :kitten_deaths_euthanasia
    t.integer :kitten_deaths_predator
    t.integer :kitten_deaths_car_or_accident
    t.integer :male_disappearances
    t.integer :female_disappearances
    t.integer :undetermined_disappearances
    t.integer :kitten_disappearances
    t.boolean :do_you_have_problems_with_predators
    t.boolean :coyote_problems
    t.boolean :racoon_problems
    t.boolean :other_predator_problems
    t.integer :number_of_male_cats_added_to_colony
    t.integer :number_of_female_cats_added_to_colony
    t.integer :number_of_undetermined_cats_added_to_colony
    t.boolean :were_tnrd_cats_returned_to_colony
    t.boolean :were_tnrd_cats_documentedphotographed
    t.integer :spayed
    t.integer :neutered
    t.string :early_age_spaying
    t.string :early_age_neutering
    t.string :where_were_cats_sn
    t.text :why_did_you_use_the_sn_services_you_did
    t.string :how_long_to_get_sn_appointment
    t.integer :most_cats_sn_at_one_time
    t.text :how_did_you_get_to_clinic
    t.boolean :did_you_have_other_drivers
    t.string :where_did_cats_recover
    t.text :how_did_cats_recover
    t.string :number_days_of_recovery_male
    t.string :number_days_of_recovery_female
    t.string :number_days_of_recovery_kittens
    t.boolean :were_cats_eartipped
    t.boolean :were_cats_vaccinated
    t.boolean :were_cats_microchipped
    t.integer :male_returned_to_colony
    t.integer :female_returned_to_colony
    t.integer :kittens_returned_to_colony
    t.integer :male_fostered_adopted
    t.integer :female_fostered_adopted
    t.integer :kittens_fostered_adopted
    t.string :trapping_resources
    t.integer :number_of_owned_traps
    t.integer :number_of_borrowed_traps
    t.string :borrowed_traps_from_where
    t.string :borrowed_carriers_for_what_purpose
    t.boolean :did_you_have_help_trapping
    t.integer :how_many_people_helpd_you_trap
    t.string :trappers_came_from_where
    t.integer :total_sn_expenses_to_date
    t.integer :expenses_to_date_for_medical_care_or_emergencies
    t.integer :colony_expenses_per_week
    t.boolean :received_money_or_free_food_to_help
    t.text :neighbourhood_statisfaction_to_cats
    t.text :neighbourhood_satisfaction_to_you_and_tnr_efforts
    t.text :issues_you_have_with_neighbours_etc
    t.boolean :free_roaming_cats_in_area
    t.boolean :owned_but_unaltered_allowed_to_roam
    t.boolean :are_cats_abandoned_near_your_colony
    t.integer :number_of_cats_abandoned_per_year_near_colony
    t.boolean :did_you_try_to_educate_neighbours_about_tnr
    t.boolean :neighbourhood_advised_re_tnr_occuring
    t.boolean :did_you_advise_others_not_to_feed_cats
    t.boolean :did_you_advise_neighbourhood_how_successful_tnr_is
    t.text :how_did_you_advise_neighbours_re_tnr_success
    t.boolean :cats_threatened_poisoned_or_killed
    t.boolean :you_or_family_been_threatenedharmed
    t.boolean :home_or_property_vandalized_due_to_cats
    t.boolean :police_bylaw_enforcement_or_animal_services_contacted
    t.text :what_was_the_issue_for_police_etc
    t.boolean :was_issue_resolved
    t.boolean :is_local_govmt_feral_friendly
    t.boolean :local_govmt_supports_tnr
    t.text :how_does_local_govmt_support_tnr
    t.boolean :do_you_have_help_caring_for_colony
    t.string :how_often_do_others_help
    t.text :how_do_others_help_you
    t.string :how_often_do_you_feed_the_colony
    t.string :what_time_of_day_do_you_feed_colony
    t.boolean :feed_in_dishes
    t.boolean :fed_open_station
    t.boolean :fed_building
    t.boolean :feeding_station
    t.boolean :fed_covered_station
    t.boolean :feed_in_dishes_on_ground
    t.boolean :food_directly_on_ground
    t.string :feed_in_other_circumstances
    t.boolean :do_you_feed_wet_food
    t.boolean :do_you_feed_dry_food
    t.boolean :do_you_feed_supplementsvitamins
    t.boolean :do_you_feed_naturopathic_or_other
    t.integer :how_many_shelters_are_in_place
    t.integer :how_many_styrofoam_shelters
    t.integer :how_many_plastic_lined_with_styrofoam
    t.integer :how_many_wooden_shelters
    t.integer :how_many_cardboard_shelters
    t.integer :how_many_other_shelters_in_place
    t.boolean :do_you_change_straw_in_spring_and_fall
    t.boolean :do_you_have_difficulty_finding_straw
    t.text :overall_condition_of_colony
    t.boolean :disease_or_ongoing_health_concerns_in_colony
    t.text :describe_ongoing_cat_health_concerns_briefly
    t.boolean :are_you_a_member_of_toronto_feral_cat_yahoo_group
    t.boolean :are_you_a_member_of_toronto_feral_cat_facebook_group
    t.boolean :are_you_a_member_of_toronto_feral_cat_other_group
    t.boolean :interested_in_seminar_on_caretaker_burnout
    t.boolean :interested_in_seminar_on_situational_awareness
    t.boolean :interested_in_self_defence
    t.text :any_suggestions_for_other_seminars
    t.text :what_support_would_help_you_with_your_colony
    t.text :what_is_your_greatest_challenge
    t.boolean :would_you_be_interested_in_helping_other_colony_caretakers
      t.timestamps null: false
    end
  end
end