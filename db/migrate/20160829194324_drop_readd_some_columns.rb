class DropReaddSomeColumns < ActiveRecord::Migration
  def change
    remove_column :colonies, :number_days_of_recovery_male
    remove_column :colonies, :neighbourhood_statisfaction_to_cats
    remove_column :colonies, :neighbourhood_satisfaction_to_you_and_tnr_efforts

    add_column :colonies, :number_days_of_recovery_male, :integer
    add_column :colonies, :neighbourhood_statisfaction_to_cats, :float
    add_column :colonies, :neighbourhood_satisfaction_to_you_and_tnr_efforts, :integer
  end
end
