module ApplicationHelper


  def randomized_background_image
    images = [
      '/assets/search-page/1.jpg', 
      '/assets/search-page/2.jpg', 
      '/assets/search-page/3.jpg', 
      '/assets/search-page/4.jpg', 
      '/assets/search-page/5.jpg', 
      '/assets/search-page/6.jpg', 
      '/assets/search-page/7.jpg',
      '/assets/search-page/8.jpg',
      '/assets/search-page/9.jpg',
      '/assets/search-page/10.jpg',
      '/assets/search-page/11.jpg',
      '/assets/search-page/12.jpg',
      '/assets/search-page/13.jpg',
      '/assets/search-page/14.jpg',
      '/assets/search-page/15.jpg'];

    images[rand(images.size)]
  end

end
