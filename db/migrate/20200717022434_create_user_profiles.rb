class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.string :name
      t.string :genre
      t.date :birth_date
      t.string :cpf

      t.timestamps
    end

    add_reference :users, :user_profile, foreign_key: true
    add_reference :addresses, :user_profile, foreign_key: true
  end
end
