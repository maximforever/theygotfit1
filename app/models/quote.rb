class Quote < ActiveRecord::Base
  
  def self.get_quote
    Quote.order_by_rand.first
  end

end
