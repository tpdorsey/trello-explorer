require 'trello'

PUBLIC_KEY = ''   # developer_public_key
MEMBER_TOKEN = '' # member_token
OAUTH_TOKEN = ''  # oauth_token
OAUTH_SECRET = '' # oauth_token_secret

Trello.configure do |config|
  config.developer_public_key = PUBLIC_KEY
  config.member_token = MEMBER_TOKEN
end

def getLabelId(label_name)
  in_label_stack = label_name.split(',')
  out_label_stack = Array.new

  in_label_stack.each do |lbl_nm|

    lbl_nm.strip!

    if lbl_nm == "Green"
      out_label_stack << ""
    elsif lbl_nm == "Yellow"
      out_label_stack << ""
    elsif lbl_nm == "Red"
      out_label_stack << ""
    elsif lbl_nm == "Purple"
      out_label_stack << ""
    # else
    #   out_label_stack << ""
    end

  end

  if out_label_stack.length < 1
    return ""
  else
    return out_label_stack.join(',')
  end
end

me = Trello::Member.find("")

my_boards = me.boards

selected_board = Trello::Board.find("")
selected_list_id = ""

board_lists = selected_board.lists

puts me.full_name
puts ""

my_boards.each do |brd|
  puts brd.name + " (" + brd.id + ")"
end
puts ""
puts ""

puts selected_board.name + " lists:"


board_lists.each do |lst|
  puts lst.name + " (" + lst.id + ")"
end
puts ""

selected_board.labels.each do |lbl|
  puts lbl.color + " (" + lbl.name + ") ID: " + lbl.id
end
puts ""

# Let's make a list of card data
# Data is [name, type of work, description, label]
# Type of work is concat with name, in parens: Alpha (Review)
card_array = [
  ["Alpha",   "Review", "Description of task", "Green,Red"],
  ["Beta",    "Create", "Description of task", "Yellow"],
  ["Gamma",   "Review", "Description of task", "Red,Blue"],
  ["Delta",   "Review", "Description of task", "Purple, Yellow"],
  ["Epsilon", "Create", "Description of task", ""]
]

card_array.each do |crd|
  name_string = crd[0] + " (" + crd[1] + ")"
  puts 'Creating card "' + name_string + '"'
  label_id = getLabelId(crd[3])
  Trello::Card.create(:name => name_string, :desc => crd[2], :list_id => selected_list_id, :card_labels => label_id)
  # puts label_id
end