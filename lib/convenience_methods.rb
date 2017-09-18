require 'time'

# Add this in eventually...
$time_zone = ''

def dti(date)
	begin
		Time.parse(date +' '+$time_zone).iso8601
	rescue => e
		e.message
	end
end

def arrf(**args)
	filter_attrs = [:attributes,:dataType,:name,:operator,:prompt,:values]
	filter_hash = {}

	filter_attrs.each do |attr|

		filter_hash[attr] = args[attr] unless args[attr].nil?
	
	end

	filter_hash
end

# alias_method :dti, :date_to_iso
# alias_method :arrf, :array_report_results_filter