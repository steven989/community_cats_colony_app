class AddSecondaryRescueOrg < ActiveRecord::Migration
  def change
    add_column :colonies, :secondary_member_of_org_or_rescue_org, :boolean
  end
end
