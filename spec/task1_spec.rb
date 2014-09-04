require 'task1'

context 'Task 1 tests' do

	let(:array) { Array.new [5,6,7,8,9,10] }

	it 'inject should sum up a series of numbers' do 
		expect(array.inject(:+)).to eq 45
	end

	it 'inject should sum up a series of numbers' do 
		expect(array.inject { | acc, x | acc + x } ).to eq 45
	end

	it 'another inject method should sum up a series of numbers using iterator' do 
		expect(array.inject_using_iterator { | acc, x | acc + x } ).to eq 45
	end

	it 'another inject method should sum up a series of numbers using iterator' do 
		expect(array.inject_using_iterator(5) { | acc, x | acc + x } ).to eq 50
	end

	it 'another inject method should sum up a series of numbers using recursion' do 
		expect(array.inject_using_recursion { | acc, x | acc + x } ).to eq 45
	end

	it 'another inject method should sum up a series of numbers using recursion' do 
		expect(array.inject_using_recursion(5) { | acc, x | acc + x } ).to eq 50
	end

end