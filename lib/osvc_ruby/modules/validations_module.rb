module OSvCRuby

	module ValidationsModule

		class << self

			def custom_error(err, example)

				puts "\n\033[31mError: #{err}\033[0m\n\n\033[33mExample:\033[0m#{example}\n\n\n\n"
				raise err
			
			end

		end

	end
	
end