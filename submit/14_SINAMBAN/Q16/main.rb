require_relative "ReutersParser"
require "httparty"

# start script 
puts 'jp.reuters.comのurlを入力してください:'
url = gets.chomp
matches = /^https:\/\/jp.reuters.com\/article\//.match?(url)
if !matches
  puts 'jp.reuters.comのみの対応ができます。もう一度やり直してください。'
end
page = HTTParty.get(url)

if page.code != 200 || page.body.nil? || page.body.empty?
  puts 'invalid url provided'
else
  parser = ReutersParser.new
  data = parser.parse(page)
  puts "タイトル : #{data[:title]}"
  puts "本文 : #{data[:text]}"
  puts "日時 : #{data[:date]}"
end