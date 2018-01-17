require 'unirest'

url = "http://localhost:3000/all_available_products"

puts "Press Enter to list all available products"
puts "=" * 50
x = gets.chomp

response = Unirest.get(url)
product_data = response.body
puts JSON.pretty_generate(product_data)