module ProductsController
  
  def products_index_action
    # response = Unirest.get("http://localhost:3000/products")
    product_hashs = get_request("/products")
    products = Product.convert_hashs(product_hashs)
    products_index_view(products)
  end

  def products_search_action
    print "Enter a name to search: "
    search_term = gets.chomp

    # response = Unirest.get("http://localhost:3000/products?search=#{search_term}")
    # product_hashs = response.body

    product_hashs = get_request("/products?search=#{search_term}")
    products = Product.convert_hashs(product_hashs)

    products_index_view(products)
  end

  def products_sort_action(attribute)
    # response = Unirest.get("http://localhost:3000/products?sort=#{attribute}")
    # product_hashs = response.body

    product_hashs = get_request("/products?sort=#{attribute}")
    products = Product.convert_hashs(product_hashs)

    products_index_view(products)
  end

  def products_show_action
    product_id = products_id_form

    # response = Unirest.get("http://localhost:3000/products/#{product_id}")
    # product_hash = response.body
    
    product_hash = get_request("/products/#{product_id}")
    product = Product.new(product_hash)

    products_show_view(product)
  end

  def products_create_action
    client_params = products_new_form

    response = Unirest.post(
                          "http://localhost:3000/products",
                          parameters: client_params
                          )
    if response.code == 200
      product_hash = response.body
      product = Product.new(product_hash)
      product_show_view(product)
    else
      errors = response.body["errors"]
      product_errors_view(errors)
    end
  end

  def products_update_action
    input_id = products_id_form

    # response = Unirest.get("http://localhost:3000/products/#{product_id}")
    # product_hash = response.body

    product_hash = get_request("/products/#{"input_id"}")
    product = Product.new(product_hash)

    client_params = products_update_form(product)


    response = Unirest.patch(
                          "http://localhost:3000/products/#{input_id}",
                          parameters: client_params
                          )
    
    if response.code == 200
      product_hash = response.body
      product = Product.new(product_hash)
      products_show_view(products)
    else
      errors = response.body["errors"]
      product_errors_view(errors)
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
