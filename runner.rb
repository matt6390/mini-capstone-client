require 'unirest'

system "clear"

puts "Welcome to My Mini Capstone"
puts "=" * 80
puts "     Press [1] For all products"
puts "     Press [2] To add a new product"
puts "     Press [3] To find a specific product"

input_option = gets.chomp

if input_option == "1"
  response = Unirest.get("http://localhost:3000/products")
  products = response.body
  puts JSON.pretty_generate(products)
elsif input_option == "2"
  client_params = {}

  print "Name: "
  client_params[:name] = gets.chomp

  print "Price: "
  client_params[:price] = gets.chomp

  print "Image URL: "
  client_params[:image_url] = gets.chomp

  print "Description: "
  client_params[:description] = gets.chomp

  response = Unirest.post(
                        "http://localhost:3000/products",
                        parameters: client_params
                        )
  product = response.body
  puts JSON.pretty_generate(product)
elsif input_option == "3"
  print "Which product would you like to see? (Please enter a number)"
  product_id = gets.chomp

  response = Unirest.get("http://localhost:3000/products/#{product_id}")

  product = response.body

  puts JSON.pretty_generate(product)
end
