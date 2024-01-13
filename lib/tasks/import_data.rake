namespace :import do
    desc "Import movies and reviews from CSV"
    task data: :environment do
      require 'csv'
  
      movies_csv_path = Rails.root.join('data', 'movies.csv')
      reviews_csv_path = Rails.root.join('data', 'reviews.csv')
       # Import movies
     CSV.foreach(movies_csv_path, headers: true) do |row|
        Movie.create(
          title: row['Movie'],
          description: row['Description'],
          year: row['Year'],
          director: row['Director'],
          actor: row['Actor'],
          filming_location: row['Filming location'],
          country: row['Country']
        )
      end
  
      # Import reviews
      CSV.foreach(reviews_csv_path, headers: true) do |row|
        movie_title = row['Movie']
        movie = Movie.find_by(title: movie_title)
        Review.create(
          movie_id: movie.id,
          user: row['User'],
          stars: row['Stars'],
          review: row['Review']
        )
      end
  
      puts "Data import completed."
    end
  end
  