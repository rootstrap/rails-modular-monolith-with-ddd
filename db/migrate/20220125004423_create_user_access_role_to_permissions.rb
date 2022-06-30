# typed: false
class CreateUserAccessRoleToPermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_access_role_to_permissions do |t|
      t.integer :role_code, null: false, index: true
      t.string :permission_code, null: false, index: true

      t.timestamps
    end
  end
end
