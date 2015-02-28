class Person < ActiveRecord::Base
  validates :firstname, :lastname, :class, :emailnonnd, presence: true
  validates :emailnd, uniqueness: true
  validates :emailnonnd, uniqueness: true
end
