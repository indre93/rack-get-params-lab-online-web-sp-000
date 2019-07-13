class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      @@cart.each do |cart_item|
        resp.write "#{cart_item}\n"
      end
    else
      resp.write "Path Not Found"
      if @@cart.empty?
        resp.write "Your cart is empty"
      end
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    elsif @@cart.empty?
      return "Your cart is empty"
    else
      return "Couldn't find #{search_term}"
    end
  end

end
