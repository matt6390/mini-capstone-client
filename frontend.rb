require 'unirest'

require_relative 'controllers/products_controller'
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
    puts "     ---Press [1.2] Sort by product price"
    puts "     ---Press [1.3] Sort by product price"
    puts "     ---Press [1.3] Sort by product description"
    puts "     Press [2] To add a new product"
    puts "     Press [3] To find a specific product"
    puts "     Press [4] to update a product"
    puts "     Press [5] to destroy a product entry"

    input_option = gets.chomp

    if input_option == "1"
      products_index_action

    elsif input_option == "1.1"
      products_search_action

    elsif  input_option == "1.2"
      products_sort_action("price")

    elsif  input_option == "1.3"
      products_sort_action("name")

    elsif  input_option == "1.4"
      products_sort_action("description")
      
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

  private

  def get_request(url, client_params={})
    Unirest.get("http://localhost:3000/#{url}", parameters: client_params).body
  end

  def patch_request(url, client_params={})
    response = Unirest.patch("http://localhost:3000/#{url}", parameters: client_params)
    if response.code == 200
      response.body
    else
      nil
    end
  end

  def post_request(url, client_params={})
    Unirest.post("http://localhost:3000/#{url}", parameters: client_params).body
  end

  def delete_request(url, client_params={})
    Unirest.delete("http://localhost:3000/#{url}", parameters: client_params).body
  end

end
