require 'unirest'

require './controllers/products_controller.rb'
#if we were to use require_relative, then we would not need the ./ or the .rb
require_relative 'views/products_views'
require_relative 'models/product'

class Frontend

  include ProductsController
  include ProductsViews

  def run
    system "clear"

    puts "Welcome to My Mini Capstone"
    puts "=" * 80
    puts "     Press [1] For all products"
    puts "     ---Press [1.1] Search all products"
    puts "     Press [2] To add a new product"
    puts "     Press [3] To find a specific product"
    puts "     Press [4] to update a product"
    puts "     Press [5] to destroy a product entry"

    input_option = gets.chomp

    if input_option == "1"
      products_index_action

    elsif input_option == "1.1"
      print "Enter a name to search: "
      search_term = gets.chomp

      response = Unirest.get("http://localhost:3000/products?search=#{search_term}")
      products = response.body
      puts JSON.pretty_generate(products)  

    elsif input_option == "2"
      products_create_action

    elsif input_option == "3"
      products_show_action

    elsif input_option == "4"
      products_update_action

    elsif input_option == "5"
      products_destroy_action

    end
  end
end
