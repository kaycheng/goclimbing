namespace :dev do
  task fake_user: :environment do
    User.destroy_all

    50.times do |i|
      user_name = Faker::Internet.username
      User.create!(
        username: user_name,
        email: Faker::Internet.email,
        password: "123456",
        intro: Faker::Lorem.paragraph
      )
    end
    
    User.create!(
      username: "admin",
      email: "admin@hot.tw",
      password: "123456",
      intro: Faker::Lorem.paragraph
    )
    
    puts "You have #{User.count} users now."
    puts "Admin already be created."
  end


  task fake_event: :environment do 
    Event.destroy_all

    500.times do |i|
      Event.create!(
        title: Faker::Lorem.word,
        note: Faker::Lorem.sentence,
        date: Faker::Time.forward(days: 5,  period: :evening, format: :long),
        location: Faker::Lorem.word,
        gather_location: Faker::Lorem.word,
        content: Faker::Lorem.sentences,
        user: User.all.sample,
        status: "published"
      )
    end

    puts "#{Event.count} events were created."
  end

  task fake_follow: :environment do 
    Follow.destroy_all

    500.times do |i|
      Follow.create!(
        user: User.all.sample,
        following: User.all.sample
      )
    end
    
    puts "#{Follow.count} follows were created."
  end

  task fake_comment: :environment do 
    Comment.destroy_all

    3000.times do |i|
      Comment.create!(
        content: Faker::Lorem.sentence,
        user: User.all.sample,
        event: Event.all.sample
      )
    end

    puts "#{Comment.count} comments were created."
  end

  task fake_participate: :environment do
    Participate.destroy_all

    3000.times do |i|
      Participate.create!(
        user: User.all.sample,
        event: Event.all.sample
      )
    end
    puts "#{Participate.count} participates were created."
  end
end