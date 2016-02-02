class CreateInvitations < ActiveRecord::Migration
    def change
        create_table :invitations do |t|
            t.string :email, null: false
            t.string :name, null: false
            t.boolean :plus_one, default: false
            t.boolean :responded, null: false, default: false
            t.datetime :response_date
        end

        add_index :invitations, [:email], unique: true
    end
end
