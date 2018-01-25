require 'unirest'

system "clear"

puts "Welcome to My Mini Capstone"
puts "=" * 80
puts "     Press [1] For all products"
puts "         Press [1.1] Search all products"
puts "     Press [2] To add a new product"
puts "     Press [3] To find a specific product"
puts "     Press [4] to update a product"
puts "     Press [5] to destroy a product entry"

input_option = gets.chomp

if input_option == "1"

  response = Unirest.get("http://localhost:3000/products")
  products = response.body
  puts JSON.pretty_generate(products)

elsif input_option == "1.1"
  print "Enter a name to search: "
  search_term = gets.chomp

  response = Unirest.get("http://localhost:3000/products?search=#{search_term}")
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
  if response.code == 200
    product = response.body
    puts JSON.pretty_generate(product)
  else
    errors = response.body["errors"]
    errors.each do |error|
      puts error
    end
  end
elsif input_option == "3"
  print "Which product would you like to see? (Please enter a number)"
  product_id = gets.chomp

  response = Unirest.get("http://localhost:3000/products/#{product_id}")

  product = response.body

  puts JSON.pretty_generate(product)

elsif input_option == "4"
  client_params = {}
  print "Enter the ID of the product you'd like to update "
  input_id = gets.chomp

  print "Name: "
  client_params[:name] = gets.chomp

  print "Price: "
  client_params[:price] = gets.chomp

  print "Image URL: "
  client_params[:image_url] = gets.chomp

  print "On Sale? (true/false): "
  client_params[:on_sale] = gets.chomp

  print "Description: "
  client_params[:description] = gets.chomp

  response = Unirest.patch(
                        "http://localhost:3000/products/#{input_id}",
                        parameters: client_params
                        )
  
  if response.code == 200
    product = response.body
    puts JSON.pretty_generate(product)
  else
    errors = response.body["errors"]
    errors.each do |error|
      puts error
    end
  end

elsif input_option == "5"
  print "Enter product id: "
  input_id = gets.chomp

  response = Unirest.delete("http://localhost:3000/products/#{input_id}")

  data = response.body
  puts JSON.pretty_generate(data)

end













