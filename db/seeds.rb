# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

10.times do 
    author = Author.create(name: Faker::Book.author, email: Faker::Internet.email, password: '123456')
    5.times do
        author.books.create(title: Faker::Book.title, description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false))
    end
end