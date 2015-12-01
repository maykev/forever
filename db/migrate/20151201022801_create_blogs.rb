class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.date :date, null: false
      t.string :entry, null: false
    end
  end
end
