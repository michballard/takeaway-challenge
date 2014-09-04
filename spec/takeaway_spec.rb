require 'takeaway'
require 'timecop'

context 'Task 2 tests' do 

	let(:takeaway) { Takeaway.new }

	def receive_and_display_order
		allow(takeaway).to receive(:gets).and_return("Noodles","2")
		takeaway.order_food
		takeaway.display_full_order
	end

	context 'initialising an order' do
		it 'is initialised with zero orders' do 
			expect(takeaway.order).to eq []
		end
	end

	context 'receiving an order' do 
		it 'allows a customer to select a dish to order from the menu' do 
			allow(takeaway).to receive(:gets).and_return("Ribs")
			expect(takeaway.order_food_item).to eq("Ribs")
		end

		it 'returns if customer does not select dish from the menu' do 
			allow(takeaway).to receive(:gets).and_return("\n")
			expect(takeaway.order_food_item).to be false
		end

		it 'allows customer to re-enter a dish if they get their order wrong' do 
			allow(takeaway).to receive(:gets).and_return("r", "ribs")
			expect(takeaway.order_food_item).to eq("Ribs")
		end 

		it 'allows a customer to select amount of dish they want to order' do 
			allow(takeaway).to receive(:gets).and_return("1")
			expect(takeaway.order_food_amount).to be 1
		end

		it 'returns if customer does not select amount of dish they want to order' do 
			allow(takeaway).to receive(:gets).and_return("\n")
			expect(takeaway.order_food_amount).to be false
		end

		it 'once a dish has been selected, displays the dish and corresponding price' do 
			allow(takeaway).to receive(:gets).and_return("Ribs","2")
			expect(takeaway.order_food).to eq [["Ribs",2, 24]]
		end

		it 'returns if customer makes an error when ordering' do 
			allow(takeaway).to receive(:gets).and_return("","")
			expect(takeaway.order_food).to be false
		end
	end

	context 'completing an order' do 
		it 'once all dishes have been selected, displays all the dishes and the total order cost' do 
			allow(takeaway).to receive(:gets).and_return("Noodles","2","Chocolate cake","2")
			takeaway.order_food
			takeaway.order_food
			expect(takeaway.display_full_order).to be 24
		end

		it 'allows customer to accept order' do 
			receive_and_display_order
			allow(takeaway).to receive(:gets).and_return("y")
			allow(takeaway).to receive(:send_confirmation_text_message)
			expect(takeaway.accept_order).to be true
		end

		it 'allows customer to reject order' do 
			receive_and_display_order
			allow(takeaway).to receive(:gets).and_return("n")
			expect(takeaway.accept_order).to be false
		end

		it 're-prompts customer if acceptance incorrectly keyed' do 
			receive_and_display_order
			allow(takeaway).to receive(:gets).and_return("/n","n")
			expect(takeaway.accept_order).to be false
		end

		it 'sends a message for the correct time' do
			time = Timecop.freeze(Time.local(2014, 9, 1, 17, 52, 0))
			expect(takeaway.delivery_message).to eq("Thank you! Your order was placed and will be delivered before 18:52")
		end
	end
	
end