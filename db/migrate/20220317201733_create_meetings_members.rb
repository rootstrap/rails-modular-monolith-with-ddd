class CreateMeetingsMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings_members do |t|
      # TODO: add another column to reference the user or user_registration
      t.string :login, null: false
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
