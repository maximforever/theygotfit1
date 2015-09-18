class Record < ActiveRecord::Base
  belongs_to :user

  validates :date,
          date: { before: Proc.new { Time.now }, message: "has to be today or earlier."
                  }

  validates :photo, format: {with: /\.(png|jpg|jpeg)\Z/i, message: "has to be a jpg, jpeg, or png."}, presence: true
  validates :height, presence: true
  validates :weight, presence: true

# WORKING SCOPE!
#  scope :find_weight,  -> (weightin) {where(weight: find_closest(weightin))}


  def self.find_weight(weightin)
    where(weight: find_closest(weightin))

    






    
  end


#  The default, SAFE option
#  scope :find_weight2,  -> (weightin) {where(weight: (weightin.to_i-5)..(weightin.to_i+5))}




def self.find_closest(num)
  if (!num.nil?)
    ref = Record.all.collect.map {|x| x.weight}
    min = ref.min_by { |x| (x.to_f - num.to_f).abs }
    puts min
    return min
  end
# STILL NEED TO MAJORLY NARROW BY GENDER
# NEED TO FIGURE OUT WHAT TO DO IF MULTIPLE RECORDS OF SAME WEIGHT

# this checks if our weight is within 10lbs of target weight. We don't need this for now.
=begin
  if (num-min).abs < 10
    return true
  else
    return false
  end
=end

end

 
  
end
