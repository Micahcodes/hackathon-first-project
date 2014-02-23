# require 'rubygems'
# require 'oauth'
# require 'json'

# # Now you will fetch /1.1/statuses/user_timeline.json,
# # returns a list of public Tweets from the specified
# # account.
# baseurl = "https://twitter.com/taahachaudhry"
# path    = "/1.1/statuses/user_timeline.json"
# query   = URI.encode_www_form(
#     "screen_name" => "twitterapi",
#     "count" => "20"
# )
# address = URI("#{baseurl}#{path}?#{query}")
# request = Net::HTTP::Get.new address.request_uri

# # Print data about a list of Tweets
# def print_timeline(tweets)
#   tweets.each do |tweet|
#         count = 0
#         if count < 20
#             puts tweet["text"]
#             count += 1
#         end
#     end

# end

# # Set up HTTP.
# http             = Net::HTTP.new address.host, address.port
# http.use_ssl     = true
# http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# consumer_key = OAuth::Consumer.new(
#     "rk5wWT0GZzaMTncOQzEnw",
#     "GCrFfLdwtu68s1vGapQMX7vGD7I3jD0Xye72nSvRjkE")
# access_token = OAuth::Token.new(
#     "459590706-dN4csFXlEWbUjuoXjKm6rhkfnTniEGeeWA8URdw9",
#     "MQ7sCbYg0et7Sss6KOqXqYJ0EjxTae3c4ylPulsoBJewa")

# # Issue the request.
# request.oauth! http, consumer_key, access_token
# http.start
# response = http.request request

# # Parse and print the Tweet if the response code was 200
# tweets = nil
# if response.code == '200' then
#   tweets = JSON.parse(response.body)
#   print_timeline(tweets)
# end
# nil
