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

  def self.master(starting, ending)

    # get all the records +/-5 of starting weight
    start_weight = Record.find_near(starting)

    # if there are none, find closest weight to starting. START = that weight
    if start_weight.size == 0 || start_weight.nil?
      puts "none found"
      master_start = find_closest(weightin)

    #if there is only one, that weight is our master_start  
    elsif start_weight.size == 1
      puts "found one record"
      u = User.find_by_id(start_weight.first.user_id)
      puts "#{u.name} weights #{start_weight.first.weight}"
      master_start = start_weight.first
   
    # If there are multiple, we skip ahead, of sorts, and dig into that user
    else
      puts "lots found! Found #{start_weight.size} starting records"      
      weight_arr = []

      start_weight.each do |record|
        #for each close starting weight, get the user
        this_user = User.find_by_id(record.user_id)
        #if the user has at least 1 record matching the ending weight, push it into our array
        weight_arr.push(record) if Record.has_weight_near?(ending, this_user)        
      end
    end

    puts "Our array so far looks like this: #{weight_arr}"

    min_user = nil
    min_difference = 999

    weight_arr.each do |rec|
      #get the user
      this_user = User.find_by_id(rec.user_id)
      #compare this user's closest starting and ending weights
      this_difference = (find_closest_w_user(starting, this_user)-find_closest_w_user(ending, this_user)).abs
      if this_difference < min_difference
        min_difference = this_difference
        min_user = this_user 
      end
    end

      puts "The user with the closest records is #{min_user.name} with the weights #{find_closest_w_user(starting, min_user)}, #{find_closest_w_user(ending, min_user)}"
  end

  def self.has_weight_near?(weight,usr)
    r = Record.where(user_id: usr.id,weight: (weight.to_i-5)..(weight.to_i+5))
    return true if r.size > 0
  end



  def self.find_near(weightin)
    where(weight: (weightin.to_i-5)..(weightin.to_i+5))
  end


#  The default, SAFE option
#  scope :find_weight2,  -> (weightin) {where(weight: (weightin.to_i-5)..(weightin.to_i+5))}

  def self.find_closest(num)
    if (!num.nil?)
      ref = Record.all.collect {|x| x.weight}
      min = ref.min_by { |x| (x.to_f - num.to_f).abs }
      puts min
      return min
    end
  end

  def self.find_closest_w_user(num, usr)
    if (!num.nil?)
      ref = usr.records.all.collect {|x| x.weight}
      min = ref.min_by { |x| (x.to_f - num.to_f).abs }
      return min
    end
  end 

  def self.weights
    weights = Record.all.collect {|r| r.weight}
    weights.sort
  end

# STILL NEED TO MAJORLY NARROW BY GENDER
# NEED TO FIGURE OUT WHAT TO DO IF MULTIPLE RECORDS OF SAME WEIGHT
end
