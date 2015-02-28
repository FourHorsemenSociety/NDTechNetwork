class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :person_id
      t.integer :year
      t.string :company
      t.string :position
      t.boolean :is_intern
      t.string :position_desc
      t.integer :sentiment
    end
  end
end
