module ProductsController
  
  def products_index_action
    response = Unirest.get("http://localhost:3000/products")
    product_hashs = response.body
    products = [ ]

    product_hashs.each do |product_hash|
      products << Product.new(product_hash)
    end 
    products_index_view(products)
  end

  def products_show_action
    print "Which product would you like to see? (Please enter a number)"
    product_id = gets.chomp

    response = Unirest.get("http://localhost:3000/products/#{product_id}")

    product_hash = response.body
    product = Product.new(product_hash)

    products_show_view(product)

  end

  def products_create_action
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
  end

  def products_update_action
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
  end

  def products_destroy_action
    print "Enter product id: "
    input_id = gets.chomp

    response = Unirest.delete("http://localhost:3000/products/#{input_id}")

    data = response.body
    puts data["message"]
  end
end