class ChangeSecondaryRscFieldType < ActiveRecord::Migration
  def change
    change_column :colonies, :secondary_member_of_org_or_rescue_org, :text
  end
end
