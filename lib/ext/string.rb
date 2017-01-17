class String
    def is_i?
       /\A[-+]?\d+\z/ === self
    end

	def camel_case_lower
		@class_to_array = self.split('')
		@class_name_length = @class_to_array.length - 1
		@output = @class_to_array.each_with_index do |letter,i|
			if i ==0
				letter.downcase!
			elsif i == @class_name_length
				letter.gsub!(/y/,'ie')
			end
		end.join

		@output + 's'
	end
end