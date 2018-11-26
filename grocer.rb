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
   num = coupon[:num]
   if cart[item]
     count = cart[item][:count]
     if count >= num
       quantity = count / num
        if cart["#{item} W/COUPON"]
          count -= num
          cart["#{item} W/COUPON"][:count] += quantity
        else
          cart["#{item} W/COUPON"] = { price: coupon[:cost], clearance: cart[item][:clearance], count: quantity }
          cart[item][:count] -= (num * quantity)
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.map do |item, data|
     if data[:clearance]
       data[:price] = (data[:price] * 0.8).round(2)
     end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  subtotal = cart.collect { |item, data| data[:price] * data[:count] }
  total = subtotal.inject(0) { |sum, x| sum + x }
  total = total > 100 ? total * 0.9 : total
end
