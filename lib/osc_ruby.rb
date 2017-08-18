require 'time'

module OSCRuby; end

# Add this in eventually...
$time_zone = ''

def dti(date)
	begin
		Time.parse(date +' '+$time_zone).iso8601
	rescue Exception => e
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

require 'osc_ruby/client'
require 'osc_ruby/connect'
require 'osc_ruby/classes/query_results'
require 'osc_ruby/classes/query_results_set'
require 'osc_ruby/classes/analytics_report_results'