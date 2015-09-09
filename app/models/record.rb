class Record < ActiveRecord::Base
  belongs_to :user

  validates :photo, format: {with: /\.(png|jpg|jpeg)\Z/i}
end
