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

me = Trello::Member.find("terrencedorsey")

my_boards = me.boards

puts "Boards for " + me.full_name
puts ""

# my_boards.each do |brd|
#   puts brd.name + " (" + brd.id + ")"
# end

long_item = my_boards.max{|a, b| a.name.length <=> b.name.length}
width = long_item.name.length

my_boards.length.times do |i|
  index = i + 1
  puts index.to_s + ". " + my_boards[i].name.ljust(width)  + " (" + my_boards[i].id + ")"
end


puts ""
print "Enter number of board: "
board = gets.chomp.to_i - 1

puts ""

selected_board = Trello::Board.find(my_boards[board].id)

puts selected_board.name + " lists:"
puts ""


selected_board.lists.each do |lst|
  puts lst.name + " (" + lst.id + ")"
end
puts ""
puts selected_board.name + " labels:"
puts ""

selected_board.labels.each do |lbl|
  puts lbl.color + ' "' + lbl.name + '" (' + lbl.id + ')'
end

