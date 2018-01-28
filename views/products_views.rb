module ProductsViews

  def products_show_view(product)
    puts
    puts "#{product.name} - Id: #{product.id}"
    puts
    puts product.description
    puts
    puts product.price
    puts product.tax 
    puts "-" * 80
    puts product.total
  end

  def product_errors_view(errors)
    errors.each do |error|
      puts error
    end
    
  end

  def products_id_form
    print "Which product would you like to see? (Please enter a number): "
    gets.chomp
  end

  def products_new_form
    client_params = {}

    print "Name: "
    client_params[:name] = gets.chomp

    print "Price: "
    client_params[:price] = gets.chomp

    print "Image URL: "
    client_params[:image_url] = gets.chomp

    print "Description: "
    client_params[:description] = gets.chomp

    client_params
  end

  def products_update_form(product)
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
    
  end

  def products_index_view(products)
    products .each do |product|
      puts "=" * 80
      products_show_view(product)
    end
  end

end