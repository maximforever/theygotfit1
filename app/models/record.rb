class Record < ActiveRecord::Base
  belongs_to :user


  validates :date,
          date: { before: Proc.new { Time.now }, message: "can't be in the future!"
                  }

  validates :photo, format: {with: /\.(png|jpg|jpeg)\Z/i, message: "has to be a jpg, jpeg, or png."}, presence: true
  validates :height, presence: true
  validates :weight, presence: true


# 1 lb = 453.59 g
# kg = lb/2.2046

# WORKING SCOPE!
#  scope :find_weight,  -> (weightin) {where(weight: find_closest(weightin))}

  @@min_user = nil
  @@final_set_of_records = []
  @@final_set_of_records.clear
  this_user = User.find_by(id: 1)


  def self.find_weight(weightin)
    where(weight: find_closest(weightin))
  end

  def self.master(starting, ending, pounds, gender, height, inches)
    @@final_set_of_records.clear
    weight_arr = []
    
    puts "POUNDS IS #{pounds}"
    puts "GENDER IS #{gender}"

    puts "HEIGHT IS #{height}"
    puts "INCHES IS #{inches}"

    pounds = false unless (pounds == "true" || pounds == true)
    inches = false unless (inches == "true" || inches == true)

    unless pounds
      puts "THIS IS IN KILOGRAMS"
      starting = (starting.to_f*2.2046).to_f.round
      ending = (ending.to_f*2.2046).to_f.round
    end

    height = false if height == "" || height == " " || height == "  " || height.nil?

    if !inches && height #if this is in centimeters AND has height
      puts "THIS IS IN CENTIMETERS"
      height = (height.to_f*0.393701).to_f.round
    end

    puts "the starting weight is: #{starting}"
    puts "the ending weight is: #{ending}"
    puts "the height is: #{height}"


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
    r = Record.find_best_from_array(weight_arr, starting, ending, gender, height)
    return r


  end


  def Record.find_best_from_array(weight_arr, starting, ending, gender, height)
    @@final_set_of_records.clear
    one_user = []
    all_users = []

    if gender == "male"
      gender = false 
    elsif gender == "female"
      gender = true 
    else
      gender == "both"
    end

    puts "GENDER IS #{gender}"
    puts "HEIGHT IS #{height}"

    weight_arr.each do |rec|
      puts "staring tests..."

      if !rec.nil? 
        this_user = User.find_by_id(rec.user_id) 
        puts "TESTING REC FOR #{this_user.name}"
        this_weight_difference = (find_closest_w_user(ending, this_user).first.weight.to_f - ending.to_f).abs
        

        this_height_difference = (find_closest_w_user(starting, this_user).first.height.to_f - height.to_f).abs if height
        

        puts "weight difference: #{this_weight_difference}"
        puts "height difference: #{this_height_difference}"

        if (this_weight_difference <= 5 && !all_users.include?(this_user))
          #if there's a matching set of records, we package these records into an array and push that into our final array.
          one_user = []
          start_record =  find_closest_w_user(starting, this_user)  
          end_record   =  find_closest_w_user(ending, this_user)


          #if gender isn't both, we make the record invalid IF it's the wrong gender or the height is off by more than 3 inches
          if gender != "both" 
            puts "GENDER: #{gender}"
            puts "USER GENDER: #{this_user.gender}"
            if gender != this_user.gender 
              start_record = end_record
            end
          end

          if !this_height_difference.nil?
            if this_height_difference >3
              start_record = end_record
            end
          end



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
      puts "The closest record is #{best_record} with the weight #{best_record.weight}"
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

  def to_pounds
    return (self.weight*2.2046).round
  end

  def to_kg
    return (self.weight/2.2046).round(1)  
  end

end


