require 'open-uri'

puts 'Cleaning up...'
List.destroy_all
Movie.destroy_all if Movie.all.any?
Bookmark.destroy_all

puts 'Seeding...'
Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
# Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)

# the Le Wagon copy of the API
url = 'http://tmdb.lewagon.com/movie/top_rated'
response = JSON.parse(URI.open(url).read)

response['results'].each do |movie|
  Movie.create(
    title: movie['original_title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
    rating: movie['vote_average'].to_f
  )
end

List.create(name: 'Action')
List.create(name: 'Comedy')
List.create(name: 'Animation')
List.create(name: 'Sci-fi')
List.create(name: 'Suspense')
List.create(name: 'Horror')
List.create(name: 'Drama')

List.all.each do |list|
  10.times do
    Bookmark.create(
      list: list,
      movie: Movie.all.sample,
      comment: Faker::Lorem.sentence
    )
  end
end

puts "#{Movie.count} movies added to db."
puts "#{List.count} lists added to db."
