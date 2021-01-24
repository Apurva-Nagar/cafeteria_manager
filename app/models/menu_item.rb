class MenuItem < ActiveRecord::Base
  belongs_to :menus

  def to_pleasant_string
    "#{id}. #{name} #{price}"
  end
end
