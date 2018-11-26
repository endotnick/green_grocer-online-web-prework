def consolidate_cart(cart)
  small_cart = {}

  cart.each do |items|
    items.each do |item, data|
      small_cart[item] = data.merge({:count => cart.count(items)})
end

def apply_coupons(cart, coupons)

end

def apply_clearance(cart)

end

def checkout(cart, coupons)

end
