class CreatePersons < ActiveRecord::Migration
  def change
    create_table :persons do |t|
      t.string :firstname
      t.string :lastname
      t.string :graduation_class
      t.string :emailnd
      t.string :emailnonnd
      t.string :currentcity
    end
  end
end
