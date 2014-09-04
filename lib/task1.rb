class Array 

	def inject_using_iterator(acc=self.shift, &block) 
		self.each do |x|
			acc = block.call(acc,x)
		end
		acc
	end

	def inject_using_recursion(acc=self.shift, array_index=0, &block) # use method that recalls itself
		if array_index < self.count
			acc = block.call(acc, self[array_index])
			acc = self.inject_using_recursion(acc, array_index + 1, &block)
		end
		acc
	end
	
end