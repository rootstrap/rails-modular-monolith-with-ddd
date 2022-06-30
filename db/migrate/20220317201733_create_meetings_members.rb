# typed: false
class CreateMeetingsMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings_members do |t|
      t.string :login, null: false
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :name, null: false
      t.uuid :identifier, null: false

      t.timestamps
    end

    add_index :meetings_members, :identifier, unique: true
  end
end
