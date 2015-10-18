module ApplicationHelper


  def randomized_background_image
    images = ['/assets/search-page/4.jpeg', '/assets/search-page/2.jpeg', '/assets/search-page/3.jpg', '/assets/search-page/4.jpeg', '/assets/search-page/5.jpeg'];

=begin

=end
    images[rand(images.size)]
  end

end
