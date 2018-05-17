# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = {}
user['password'] = '1234'

ActiveRecord::Base.transaction do
  10.times do 
    user['first_name'] = Faker::Name.first_name 
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email
    user['role'] = rand(1..2)
    user['qualification'] = Faker::Educator.course

    User.create(user)
  end
end 

# Seed Question
question = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do 
    question['title'] = Faker::HowIMetYourMother.quote
    question['description'] = Faker::ChuckNorris.fact

    question['user_id'] = uids.sample

    Question.create(question)
  end
end

# Seed Answer
answer = {}
qids = []
Question.all.each { |q| qids << q.id }

ActiveRecord::Base.transaction do
  100.times do 
    answer['answer'] = Faker::FamilyGuy.quote
    answer['anonymous'] = rand(0..1)

    answer['user_id'] = uids.sample
    answer['question_id'] = qids.sample

    Answer.create(answer)
  end
end

# Seed Vote
vote = {}
aids = []
Answer.all.each { |a| aids << a.id }

ActiveRecord::Base.transaction do
  500.times do 
    vote['vote'] = rand(0..1)

    vote['user_id'] = uids.sample

    r_vote = rand(0..1)
    if r_vote == 0
    	vote['question_id'] = qids.sample
    else
    	vote['answer_id'] = aids.sample
    end

    Vote.create(vote)
  end
end