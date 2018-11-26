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
    item = coupon[:item]
    if cart[item]
      count = cart[item][:count]
      if count <= item[:count]
        if cart.has_key?(item_key + " W/COUPON")
          amount = cart[item_key][:count] / coupon[:num]
          cart[item_key][:count] -= coupon[:num]
          cart[item_key + " W/COUPON"][:count] += amount
        #  binding.pry
        else
          amount = cart[item_key][:count] / coupon[:num]
          clearance=cart[item_key][:clearance]
          cart[item_key + " W/COUPON"] = {price: coupon[:cost], clearance: clearance, count: amount}
          cart[item_key][:count] -= (coupon[:num] * amount)
        #  binding.pry
        end
=begin
        if count > 0
          cart[item][:count] = count / coupon[:num]
        elsif count == 0
          cart.delete(item)
        end

        if !(count < 0)
          entry =  { :price => item[:cost], :clearance => cart[item][:clearance], :count => count / coupon[:num] }
          cart["#{item} W/COUPON"] = entry
        end
=end

      end
    end
  end
  cart
end

def apply_clearance(cart)

end

def checkout(cart, coupons)
  cart = consolidate_cart(cart).apply_coupons(coupons).apply_clearance
end
