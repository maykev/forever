class CreateInvitees < ActiveRecord::Migration
  def change
    create_table :invitees do |t|
      t.string :name, null: false
      t.boolean :accepted
      t.references :invitation
    end
  end
end
