require 'pry'

def consolidate_cart(cart)
  # binding.pry
  basket = {}
    cart.each do |item| # cart is an array of items
      item.each do |name, details| # each item has a name and a hash of details
        if basket.has_key?(name) # could also just say 'if basket[name]'...(if item with that name is already in the basket it will evaluate to true)
          basket[name][:count] += 1 # if its in the basket already it will have :count key
        else
          basket[name] = details # add a new key/value pair...(details will bring all its values with it)
          basket[name][:count] = 1 # add a count key set to 1 of that item
        end
      end
    end
  basket
  # binding.pry
end

def apply_coupons(cart, coupons)
  # binding.pry
  coupons.each do |coupon|
    grocery = coupon[:item]
    if cart.has_key?(grocery) && cart[grocery][:count] >= coupon[:num]
      if cart["#{grocery} W/COUPON"] # if this entry exists, you've already applied a coupon, so...
        # apply the next one, increment count, decrement number of items left in cart 'uncoupened'
        cart["#{grocery} W/COUPON"][:count] += 1
        cart[grocery][:count] -= coupon[:num]
      else
        # set the 'couponed' entry with count of 1...
      cart["#{grocery} W/COUPON"] = {:price => coupon[:cost], :count => 1, :clearance => cart[grocery][:clearance]}
      cart[grocery][:count] -= coupon[:num] # decrement uncoupened items left in cart
      end
    end
  end
  cart
  # binding.pry
end


def apply_clearance(cart) # not an array in this test case!
  # binding.pry
  cart.each do |grocery, values|
    if values[:clearance]
      values[:price] = (values[:price] * 0.8).round(2)
    end
  end
  cart
  # binding.pry
end

def checkout(cart, coupons)
  consolidated = consolidate_cart(cart)
  binding.pry
  couponed = apply_coupons(consolidated, coupons)
  binding.pry
  cleared = apply_clearance(couponed)
   binding.pry
  # calculate the total
  total = 0
  cleared.each do |item, attributes|
    total += attributes[:price]
    # binding.pry
  end
  total
  binding.pry


end
