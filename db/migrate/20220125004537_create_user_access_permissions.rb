# typed: false
class CreateUserAccessPermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_access_permissions do |t|
      t.string :code, null: false, index: true
      t.string :name, null: false
      t.string :description

      t.timestamps
    end
  end
end
