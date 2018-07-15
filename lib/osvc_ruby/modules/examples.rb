ANALYTICS_REPORT_RESULTS_NO_JSON = <<~HEREDOC
require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
    c.username = env['OSC_ADMIN'],
    c.password = env['OSC_PASSWORD'],
    c.interface = env['OSC_SITE'],
end

response = OSvCRuby::AnalyticsReportResults.run(
    client: rn_client,
    \033[32mjson: {
        "id" => 176,
        "limit" => 1
    }\033[0m
)
HEREDOC

ANALYTICS_REPORT_RESULTS_NO_ID_OR_LOOKUPNAME = <<~HEREDOC
require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
    c.username = env['OSC_ADMIN'],
    c.password = env['OSC_PASSWORD'],
    c.interface = env['OSC_SITE'],
end

response = OSvCRuby::AnalyticsReportResults.run(
    client: rn_client,
    json: {
        \033[32m"id" => 176,\033[0m
        "limit" => 1
    }
)
HEREDOC

ANNOTATION_MUST_BE_SHORTER_THAN_40_CHARACTERS = <<~HEREDOC
require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
    c.username = env['OSC_ADMIN'],
    c.password = env['OSC_PASSWORD'],
    c.interface = env['OSC_SITE'],
    c.version = "v1.4"
)

response = OSvCRuby::AnalyticsReportResults.run(
    client: rn_client,
    json: {
        "id" => 176,
        "limit" => 1
    },
    \033[32mannotation: "Running Answer Search"\033[0m
)
HEREDOC

CLIENT_NOT_DEFINED = <<~HEREDOC
require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
    c.username = env['OSC_ADMIN'],
    c.password = env['OSC_PASSWORD'],
    c.interface = env['OSC_SITE'],
end

response = OSvCRuby::AnalyticsReportResults.run(
    \033[32mclient: rn_client\033[0m,
    json: {
        "id" => 176,
        "limit" => 1
    }
)
HEREDOC


CLIENT_NO_USERNAME_SET_EXAMPLE = <<~HEREDOC
require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
    \033[32mc.username = env['OSC_ADMIN']\033[0m,
    c.password = env['OSC_PASSWORD'],
    c.interface = env['OSC_SITE'],
end

HEREDOC

CLIENT_NO_PASSWORD_SET_EXAMPLE = <<~HEREDOC
require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
    c.username = env['OSC_ADMIN'],
    \033[32mc.password = env['OSC_PASSWORD']\033[0m,
    c.interface = env['OSC_SITE'],
end

HEREDOC

CLIENT_NO_INTERFACE_SET_EXAMPLE = <<~HEREDOC
require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
    c.username = env['OSC_ADMIN'],
    c.password = env['OSC_PASSWORD'],
    \033[32mc.interface = env['OSC_SITE']\033[0m,
end

HEREDOC

FILE_UPLOAD_ERROR = <<~HEREDOC
require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
    c.username = env['OSC_ADMIN'],
    c.password = env['OSC_PASSWORD'],
    c.interface = env['OSC_SITE'],
end

data = {
    "primaryContact" => {
        "id" => 2
    },
}

response = OSvCRuby::Connect.post(
    client: rn_client,
    url: 'incidents?expand=all',
    json: data,
    debug: true,
    \033[32mfiles: ["./setup.py"]\033[0m
)
HEREDOC

QUERY_RESULTS_NO_QUERY = <<~HEREDOC
require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
    c.username = env['OSC_ADMIN'],
    c.password = env['OSC_PASSWORD'],
    c.interface = env['OSC_SITE'],
end

results = OSvCRuby::QueryResults.query(
    \033[32mquery='DESCRIBE',\033[0m
    client: rn_client,
)
HEREDOC

QUERY_RESULTS_SET_NO_QUERIES = <<~HEREDOC
require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
    c.username = env['OSC_ADMIN'],
    c.password = env['OSC_PASSWORD'],
    c.interface = env['OSC_SITE'],
end

results = OSvCRuby::QueryResultsSet.query_set(
    \033[32mqueries: [
        {key:"incidents", query: "DESCRIBE incidents"},
        {key:"serviceProducts", query:"DESCRIBE serviceProducts" }
    ]\033[0m,
    client: rn_client,
)
HEREDOC