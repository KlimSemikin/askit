# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# 30.times do
#   title = Faker::Hipster.sentence(word_count: 3)
#   body = Faker::Lorem.paragraph(sentence_count: 10, supplemental: true, random_sentences_to_add: 4)
#   user = User.all.sample
#   Question.create(title:, body:, user:)
# end
#
# 100.times do
#   question = Question.all.sample
#   body = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)
#   user = User.all.sample
#   question.answers.create(question:, body:, user:)
# end
#
# 30.times do
#   title = Faker::Hipster.word
#   Tag.create title:
# end
#
# 5.times do
#   email = Faker::Internet.email
#   name = Faker::Name.name
#   password = 'Bbe31kchuw!'
#   role = 'basic'
#
#   User.create(email:, name:, password:, role:)
# end
#
# 30.times do
#   question = Question.all.sample
#   tags = Tag.ids.sample([1,2,4].sample)
#
#   question.tag_ids = tags
#   question.save
# end