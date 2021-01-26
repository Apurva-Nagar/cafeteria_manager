class MenuItem < ActiveRecord::Base
  belongs_to :menu, optional: true
  validates :name, presence: true
  validates :price, presence: true
  validates :description, length: { minimum: 10 }
  validates :menu_id, presence: true
end
