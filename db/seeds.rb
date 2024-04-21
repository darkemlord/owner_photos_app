# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:

puts '============================'
puts 'Start seeding'

image_files = [
  'app/assets/images/image1.png',
  'app/assets/images/image2.jpeg',
  'app/assets/images/image3.jpeg',
  'app/assets/images/image4.jpeg',
  'app/assets/images/me.jpg'
]

# Create 10 users
10.times do |i|
  user = User.create(user_id: "user#{i}", password: 'password')
  num_images = rand(1..5)
  images_to_attach = image_files.shuffle.take(num_images)
  images_to_attach.each do |image|
    user.images.attach(io: File.open(image), filename: File.basename(image))
  end
end

me = User.create(user_id: 'emanuel', password: 'password')
image_files.each do |image|
  me.images.attach(io: File.open(image), filename: File.basename(image))
end

puts 'Succesfully done!'
puts '============================'
