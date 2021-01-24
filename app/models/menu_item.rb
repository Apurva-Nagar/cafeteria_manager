class MenuItem < ActiveRecord::Base
  belongs_to :menu, optional: true

  def to_pleasant_string
    "#{id}. #{name} #{price}"
  end
end
