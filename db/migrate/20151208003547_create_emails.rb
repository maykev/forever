class CreateEmails < ActiveRecord::Migration
    def change
        create_table :emails do |t|
            t.string :from, null: false
            t.string :name, null: false
            t.string :message, null: false

            t.timestamps null: false
        end
    end
end
