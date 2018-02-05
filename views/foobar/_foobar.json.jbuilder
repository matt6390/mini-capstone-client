  json.id @foobar.id
  json.name @foobar.name
  json.pictures @foobar.pictures



  json.description @foobar.description
  json.is_discounted @foobar.is_discounted
  json.price @foobar.price
  json.tax @foobar.tax
  json.total @foobar.total

  json.formatted do
                    json.price number_to_currency(@foobar.price)
                    json.tax number_to_currency(@foobar.tax)
                    json.total number_to_currency(@foobar.total)
                  end


  json.supplier @foobar.supplier
  json.order @foobar.orders