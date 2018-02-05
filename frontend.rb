require 'unirest'

require_relative 'controllers/products_controller'
#if we were to use require_relative, then we would not need the ./ or the .rb
require_relative 'views/products_views'
require_relative 'models/product'

class Frontend

  include ProductsController
  include ProductsViews

  def run
   
    while true

    
        system "clear"
    
        puts "Welcome to My Mini Capstone"
        puts "=" * 80
        puts "     Press [1] For all products"
        puts "     ---Press [1.1] Search all products"
        puts "     ---Press [1.2] Sort by product price"
        puts "     ---Press [1.3] Sort by product name"
        puts "     ---Press [1.4] Sort by product description"
        puts "     ---Press [1.5] Show products by category"
        puts "     Press [2] To add a new product"
        puts "     Press [3] To find a specific product"
        puts "     Press [4] to update a product"
        puts "     Press [5] to destroy a product entry"
        puts "     Press [6] to show all orders"
        puts 
        puts "     Press [cart] Show Shopping Cart"
        puts ""
        puts "     [signup] Creates a User"
        puts "     [login] Login (creates a JSON web token)"
        puts "     [logout] Logout (erases all JSON web tokens)"
        puts "     [q] Quit"
    
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

      elsif input_option == "1.5"
        puts
        response = Unirest.get("http://localhost:3000/categories")
        category_hashs = response.body 
        puts "Categories:"
        puts "-" * 40
        category_hash.each do |category_hash|
          puts "- #{category_hash["name"]}"
        end

        print "Enter a category name: "
        category_name = gets.chomp
        response = Unirest.get("http://localhost:3000/products?category=#{category_name}")
        product_hashs = response.body

        product_hashs.each do |product_hash|
          puts "- #{product_hash["name"]}"
        end

        
        
      elsif input_option == "2"
        products_create_action

      elsif input_option == "3"
        products_show_action
      
      elsif input_option == "4"
           products_update_action
      
      elsif input_option == "5"
           products_destroy_action

      elsif input_option == "6"
        orders_hashs = get_request("/orders")
        puts JSON.pretty_generate(orders_hashs)

      elsif input_option == "cart"
        puts 
        puts "Here are all of the items in your shopping cart"
        puts

        response = Unirest.get("http://localhost:3000/carted_products")
        carted_products = response.body
        
        # carted_products.each do |carted_products_hash|
        #   puts "   * #{carted_products_hash["product"]["name"]}"
        # end

        puts JSON.pretty_generate(carted_products)

        puts "Press Enter to continue, or press 'o' to place the order"

        if gets.chomp == 'o'
          response = Unirest.post("http://localhost:3000/orders")
          order_hash = response.body 
          puts JSON.pretty_generate(order_hash)
        end





        
          
      
      elsif input_option == "signup"
        puts "Signup!"
        puts
        client_params = {}

        print "Name: "
        client_params[:name] = gets.chomp
        
        print "Email: "
        client_params[:email] = gets.chomp
        
        print "Password: "
        client_params[:password] = gets.chomp
        
        print "Password confirmation: "
        client_params[:password_confirmation] = gets.chomp
        
        response = Unirest.post("http://localhost:3000/users", parameters: client_params)
        puts JSON.pretty_generate(response.body)

      elsif input_option == "login"
        puts "Login"
        puts 
        print "Email: "
        input_email = gets.chomp

        print "Password: "
        input_password = gets.chomp

        response = Unirest.post(
                                "http://localhost:3000/user_token",
                                parameters: { 
                                              auth: {
                                                      email: input_email,
                                                      password: input_password
                                                      }
                                              }
                                )
        puts JSON.pretty_generate(response.body)
        jwt = response.body["jwt"]
        Unirest.default_header("Authorization", "Bearer #{jwt}")

      elsif input_option == "logout"
        jwt = ""
        Unirest.clear_default_headers
      
      elsif input_option == "q"
        puts "Thanks for using"
        exit
      end
      gets.chomp
    end
  end
       
private
    def get_request(url, client_params={})
      Unirest.get("http://localhost:3000#{url}", parameters: client_params).body
    end

    def post_request(url, client_params={})
      Unirest.post("http://localhost:3000#{url}", parameters: client_params).body
    end

    def patch_request(url, client_params={})
      Unirest.patch("http://localhost:3000#{url}", parameters: client_params).body
    end

    def delete_request(url, client_params={})
      Unirest.delete("http://localhost:3000#{url}", parameters: client_params).body
    end
end


