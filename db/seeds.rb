# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


5.times do User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.safe_email, password: Faker::Internet.password)
end

User.all.each do |user|
  user.skills.create(title: Faker::Hipster.word, description:Faker::Hipster.paragraph)
end

Skill.all.each do |skill|
  some_time = Faker::Time.between(5.days.ago, 5.days.from_now)
  skill.lessons.create(
    teacher_rating_student: rand(1..5), 
    student_rating_teacher: rand(1..5), 
    start_time: some_time, 
    end_time: (some_time + (60*60)), 
    requested_at: (some_time - (60*60*24)*rand(1..3)), 
    confirmed_at: (some_time - (5*60*60)),
    teacher_id: skill.teacher.id,
    student_id: (User.all.pluck(:id) - [skill.teacher.id]).sample
  )
end