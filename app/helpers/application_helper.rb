module ApplicationHelper


  def randomized_background_image
    images = [
      '/search-page/1.jpg', 
      '/search-page/2.jpg', 
      '/search-page/3.jpg', 
      '/search-page/4.jpg', 
      '/search-page/5.jpg', 
      '/search-page/6.jpg', 
      '/search-page/7.jpg',
      '/search-page/8.jpg',
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
