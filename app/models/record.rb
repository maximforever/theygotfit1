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

  @@min_user = nil
  @@final_set_of_records = []
  @@final_set_of_records.clear
  this_user = User.find_by(id: 1)

  def self.find_weight(weightin)
    where(weight: find_closest(weightin))
  end

  def self.master(starting, ending)
    @@final_set_of_records.clear
    weight_arr = []
    # get all the records +/-5 of starting weight
    start_weight = Record.find_near(starting)

    # if there are none, find closest weight to starting. START = that weight
    if start_weight.size == 0 || start_weight.nil?
      puts "none found"
      #if we don't find anything, let's add the closest weight IF it has a close end weight
      start_weight = find_closest(starting)
      this_user = User.find_by_id(start_weight.user_id) if !this_user.nil?

      if !this_user.nil?
        if Record.has_weight_near?(ending, this_user)
          weight_arr.push(start_weight) 
        else
          #if there's no good starting weight AND no good ending weight, we push a nil into the array
          weight_arr.push(nil)
        end
      end

    #if there is only one, that weight is our start_weight  
    elsif start_weight.size == 1
      puts "found one record, the weight is: #{start_weight.first.weight}"
      start_weight = start_weight.first
      this_user = User.find_by_id(start_weight.user_id)
     
      if Record.has_weight_near?(ending, this_user)
        weight_arr.push(start_weight) 
      else
        #if there's no good ending weight, we push a nil into the array
        weight_arr.push(nil)
      end


      puts "Weight array is now #{weight_arr}"


    # If there are multiple, we skip ahead, of sorts, and dig into that user
    else
      puts "lots found! Found #{start_weight.size} starting records"      
      start_weight.each do |record|
        #for each close starting weight, get the user
        this_user = User.find_by_id(record.user_id)
        #if the user has at least 1 record +/- 5 the ending weight, push it into our array
        if Record.has_weight_near?(ending, this_user)
          weight_arr.push(record) 
        else
          #if there's no good starting weight AND no good ending weight, we push a nil into the array
          weight_arr.push(nil)
        end

        puts "Weight array is now #{weight_arr}"     
      end
    end

    puts "WEIGHT ARRAY BEFORE SENDING OFF: #{weight_arr}"
    r = Record.find_best_from_array(weight_arr, starting, ending)

    return r
  end


  def Record.find_best_from_array(weight_arr, starting, ending)
    @@final_set_of_records.clear
    min_difference = 999

    weight_arr.each do |rec|
      if !rec.nil? 
        #get the user
        this_user = User.find_by_id(rec.user_id) 
        #compare this user's closest starting and ending weights
        this_difference = (find_closest_w_user(starting, this_user)-find_closest_w_user(ending, this_user)).abs
           
        if this_difference < min_difference
          min_difference = this_difference
          @@min_user = this_user 
          puts "Adding #{@@min_user.name} to the array!"
        end
      end
    end

#      puts "The user with the closest records is #{@@min_user.name} with the weights #{find_closest_w_user(starting, @@min_user)}, #{find_closest_w_user(ending, @@min_user)}" 
      if !@@min_user.nil?
        master_start_record = Record.where(user_id: @@min_user.id, weight: find_closest_w_user(starting, @@min_user))
        master_end_record = Record.where(user_id: @@min_user.id, weight: find_closest_w_user(ending, @@min_user))


        #we need to check if our final closest records are within 5 lbs of the requirements.
        #if they're not, we need to pass nil measurments.


        if ((master_start_record.first.weight.to_i-starting.to_i).abs >5)
          puts "starting is too far off!"
          master_start_record.first = nil
        end
        if ((master_end_record.first.weight.to_i-ending.to_i).abs >5)
          puts "ending is too far off!"
          master_end_record.first = nil 
        end



        @@final_set_of_records.push(master_start_record.first)
        @@final_set_of_records.push(master_end_record.first)
        puts "weights returned!"
      end
    puts "FINAL WEIGHTS: #{@@final_set_of_records}"
    return @@final_set_of_records

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
    if (!num.nil? && !usr.nil?)
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


