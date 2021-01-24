class MenuItem < ActiveRecord::Base
  def to_pleasant_string
    "#{id}. #{name} #{price}"
  end
end
