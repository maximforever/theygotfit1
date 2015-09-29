class Record < ActiveRecord::Base
  belongs_to :user

  validates :date,
          date: { before: Proc.new { Time.now }, message: "can't be in the future!"
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
    puts "starting search"
    # if there are none, find closest weight to starting.
    if start_weight.size == 0 || start_weight.nil?
      #if we don't find anything, let's add the closest weight
      puts "none found" 
      start_weight = find_closest(starting)
      weight_arr.push(start_weight) 
      puts "Weight array is now #{weight_arr}"

    #if there is only one, that weight is our start_weight  
    elsif start_weight.size == 1
      puts "found one"
      #if we find one campaign, we push that into the array
      start_weight = start_weight.first
      weight_arr.push(start_weight) 
#      puts "found one record, the weight is: #{start_weight.first.weight}"
#      puts "Weight array is now #{weight_arr}"


    # If there are multiple, we skip ahead, of sorts, and dig into that user
    else
      puts "lots found! Found #{start_weight.size} starting records"      
      start_weight.each do |record|      
        weight_arr.push(record) 
      end     
    end
    # our weight_array contains all user records with a close starting weight: within +/-5
    puts "Weight array is now #{weight_arr}"
    r = Record.find_best_from_array(weight_arr, starting, ending)
    return r


  end


  def Record.find_best_from_array(weight_arr, starting, ending)
    @@final_set_of_records.clear
    one_user = []
    all_users = []
    weight_arr.each do |rec|
      puts "staring tests..."

      if !rec.nil? 
        this_user = User.find_by_id(rec.user_id) 
        puts "TESTING REC FOR #{this_user.name}"
        this_difference = (find_closest_w_user(ending, this_user).first.weight.to_f-ending.to_f).abs
        puts this_difference
        if (this_difference <= 5 && !all_users.include?(this_user))
          #if there's a matching set of records, we package these records into an array and push that into our final array.
          one_user = []
          start_record =  find_closest_w_user(starting, this_user)  
          end_record   =  find_closest_w_user(ending, this_user)
          unless (start_record == end_record)
            all_users.push(this_user)
            one_user.push(start_record, end_record)
            one_user.push()
            @@final_set_of_records.push(one_user)
            puts "SUCCESS! Adding #{this_user.name} to the array!"
          end
          puts "The array now includes #{@@final_set_of_records}"
        end
      end
    end
    @@final_set_of_records.uniq!
    puts "FINAL WEIGHTS: #{@@final_set_of_records}"
    puts "FINAL WEIGHT ARRAY SIZE: #{@@final_set_of_records.size}"
    return @@final_set_of_records

  end





  def self.has_weight_near?(weight,usr)
    r = Record.where(user_id: usr.id,weight: (weight.to_i-5)..(weight.to_i+5))
    return true if r.size > 0
  end



  def self.find_near(weightin)
    where(weight: (weightin.to_i-5)..(weightin.to_i+5))
  end


  def self.find_closest(num)
    if (!num.nil?)
      ref = Record.all.collect {|x| x.weight}
      min = ref.min_by { |x| (x.to_f - num.to_f).abs }
      best_record = Record.find_by(weight: min)
      puts "The closest record is #{best_record}"
      return best_record
    end
  end

  def self.find_closest_w_user(num, usr)
    if (!num.nil? && !usr.nil?)
      ref = usr.records.all.collect {|x| x.weight}
      min = ref.min_by { |x| (x.to_f - num.to_f).abs }
      best_rec = Record.where(user_id: usr.id, weight: min)
      return best_rec
    end
  end 


  def self.weights
    weights = Record.all.collect {|r| r.weight}
    weights.sort
  end

# STILL NEED TO MAJORLY NARROW BY GENDER
# NEED TO FIGURE OUT WHAT TO DO IF MULTIPLE RECORDS OF SAME WEIGHT
end


