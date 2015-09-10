class Record < ActiveRecord::Base
  belongs_to :user

  validates :date,
          date: { before: Proc.new { Time.now }, message: "has to be today or earlier."
                  }

  validates :photo, format: {with: /\.(png|jpg|jpeg)\Z/i, message: "has to be a jpg, jpeg, or png."}, presence: true
  validates :height, presence: true
  validates :weight, presence: true
end
