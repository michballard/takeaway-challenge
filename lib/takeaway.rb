require 'rubygems'
require 'twilio-ruby'

class Takeaway

	TAKEAWAY_MENU = [{dish: "Ribs", price: 12}, {dish: "Salmon", price: 10}, {dish: "Risotto", price: 9}, {dish: "Noodles", price: 8}, {dish: "Sushi", price: 6}, {dish: "Fries", price: 4}, {dish: "Sundae", price: 5}, {dish: "Chocolate cake", price: 4}]
	attr_accessor :order
	attr_accessor :order_item

	def initialize
		@order = []
		@order_item = []
	end

	# List dishes with prices
	def print_menu # 1. Run this method to display full menu
		print_menu_header
		print_menu_list
	end

	def print_menu_header
	  header = "Michelle's Cafe Menu"
	  line = "----------------------------"
  	print "\n"	  
	  puts line
	  puts header 
	  puts line
	end

	def print_menu_list
		TAKEAWAY_MENU.each_with_index do |dish, count|
			puts "#{count + 1}. #{dish[:dish]}  £#{dish[:price]}"
		end
		nil
	end

	# Receive food order
	def order_food # 2. Run this method to order a type of food
		calculate_order_line_cost if order_food_item && order_food_amount
		if complete_order?(@order_item)
			@order << @order_item
		else
			return false
		end
	end

	def order_food_item
		@order_item = []
		dish = ""
		puts "Enter name of food you want to order:"
		loop do 
			dish = gets.chomp.capitalize
			if dish.empty?
				return false
				break
			elsif search_menu_for(dish)
				@order_item << dish
				break
			else
				puts "Please re-enter name of food:"
			end
		end
		dish
	end

	def search_menu_for(dish)
		TAKEAWAY_MENU.find { |hash| hash[:dish] == dish }
	end

	def order_food_amount
		puts "Enter how many you want to order:"
		amount = gets.chomp.to_i
		return false if amount == 0 
		@order_item << amount
		amount
	end

	def calculate_order_line_cost
		selected_item = search_menu_for(@order_item[0])
		cost = selected_item[:price] * @order_item[1]
		@order_item << cost
		cost
	end

	def complete_order?(order)
		order.count == 3
	end

	# Show complete order and confirmation
	def complete_order # 3. Run this method to print order and accept/reject
		display_full_order
		accept_order	
	end

	def display_full_order
		puts "This is your takeaway order:"
		print_order_items
		total_cost = @order.inject(0) { | acc, item_cost | acc + item_cost[2] }
		puts "Total cost: £#{total_cost}"
		total_cost
	end

	def print_order_items
		count = 0
		until count >= @order.count
			order_item = @order[count]
			count += 1
			puts "#{count}. #{order_item[0]} x #{order_item[1]}"
		end
	end

	def accept_order
		puts "Would you like to accept this order? Please enter Y or N:"
		loop do
			accept = gets.chomp.capitalize
			if accept == "Y"
				puts "Order accepted"
				send_confirmation_text_message
				return true
			elsif accept == "N"
				puts "Order not accepted"
				return false
			else
				"Please re-enter your response, Y or N?"
			end
		end
	end

	def send_confirmation_text_message
		# my account credentials 
		account_sid = 'AC590bc4adceab1e605b01bccb365d054e'
		auth_token = '6c7d146c7c298b9f5cee71d733eabfe5'

		# set up a client to talk to the Twilio REST API
		client = Twilio::REST::Client.new account_sid, auth_token

		# send an sms
		client.account.messages.create({
		  :from => '+441938880005',
		  :to => '+447449928801',
		  :body => delivery_message 
		  })
	end

	def delivery_message
		delivery_time = Time.now + 3600
		"Thank you! Your order was placed and will be delivered before #{delivery_time.strftime("%H:%M")}"
	end
	
end

