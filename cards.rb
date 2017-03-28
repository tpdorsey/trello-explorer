require 'trello'

PUBLIC_KEY = ''   # developer_public_key
MEMBER_TOKEN = '' # member_token
OAUTH_TOKEN = ''  # oauth_token
OAUTH_SECRET = '' # oauth_token_secret

counter = 1

Trello.configure do |config|
  config.developer_public_key = PUBLIC_KEY
  config.member_token = MEMBER_TOKEN
end

selected_list = Trello::List.find("") # Put the ID of the list here

puts "found list " + selected_list.name

cards = selected_list.cards

puts selected_list.name + " contains " + cards.length.to_s + " cards"

cards.each do |crd|

  labels = ""
  crd.card_labels.each do |lbl|
    if labels.length == 0
      labels << lbl["name"]
    else
      labels << lbl["name"] + ","
    end
  end

  puts '"' + crd.name + '","' + crd.desc + '","' + labels + '"'
end

