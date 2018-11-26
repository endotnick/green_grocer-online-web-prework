def consolidate_cart(cart)
  small_cart = {}

  cart.each do |items|
    items.each do |item, data|
      small_cart[item] = data.merge({ :count => cart.count(items) })
    end
  end
  small_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    coupon.each do |
end

def apply_clearance(cart)

end

def checkout(cart, coupons)
  cart = consolidate_cart(cart).apply_coupons(coupons).apply_clearance
end
