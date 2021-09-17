require 'sinatra' 
require 'sinatra/reloader' if development?
require 'bcrypt' 


require_relative 'models/user.rb' 
require_relative 'models/card.rb' 
require_relative 'models/comments.rb' 

also_reload 'models/card.rb' if development?
also_reload 'models/user.rb' if development?
also_reload 'models/comments.rb'if development?

enable :sessions

def logged_in?()
  if session[:user_id]
    return true
  else
    return false
  end
end

def current_user()
  user = find_user_by_id(session[:user_id])
  return user
end

get '/' do

  # cards = find_all_cards()
  cards = find_all_cards_desc()

  erb :index, locals: { cards: cards}
end

get '/mockup' do
  "I am the mockup page"
  erb :mockup
end


#Create card form
get '/create_new_card' do
  erb :create_new_card
end

#Card ID Details
get '/cards/:id' do
  card = find_card_by_id(params["id"])
  comments = find_comments_by_card_id(params["id"])
  user_of_comment = find_user_by_comment_user_id(params["id"]) ##TRY TO GET THIS TO WORK

  erb :card_details, locals: {
    card: card,
    comments: comments,
    user_of_comment: user_of_comment,
  }

end

get '/cards' do
  "I list all cards"
  cards = find_all_cards()

  erb :cards, locals: {
    cards: cards
  }
end

get '/about' do
  "I am the about page"
  erb :about
end

#POST Make card
post '/cards' do
  # create_card(params["title"], params["attack"], params["health"], params["rarity"], params["text_description"], params["cost"], params["image_url"], current_user["id"])
  if logged_in?()
    create_card(params["title"], params["attack"], params["health"], params["rarity"], params["text_description"], params["cost"], params["image_url"], current_user["id"])
  else 
    create_card_guest(params["title"], params["attack"], params["health"], params["rarity"], params["text_description"], params["cost"], params["image_url"])
  end
  redirect "/"
end

#Update/edit form
get '/cards/:id/edit' do
  "I am the edit page"
  card = find_card_by_id(params[:id])
  erb :edit_card, locals: { card: card }
end


#Update/Edit Card
put '/cards/:id' do
  update_card(params[:id], params[:title], params[:attack], params[:health], params[:rarity], params[:text_description], params[:cost], params[:image_url])

  redirect "/cards/#{params[:id]}"
end

# Post Comment
post '/cards/:id' do

  create_comment(Time.now, params["comment"], current_user["id"], params[:id])
  
  # CHRIS' TIME CODE
  # time = Time.parse(current_items[0]['creation_time']).strftime("%d/%m/%Y %H:%M") 


  redirect "/"

end

#Delete the card here
delete '/cards/:id' do
  delete_card(params[:id])
  redirect "/"
end


#########
## USER LOGINS
#########

get '/login' do
  "Show login screen"
  erb :login
end

post '/session' do
  "I am logging in"
  user = find_user_by_email(params[:email])
  if user && BCrypt::Password.new(user["password_digest"]).==(params[:password])
  session[:user_id] = user["id"]
  redirect '/'
  else 
    # Do nothing
    erb :login
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect '/login'
end


get '/sign_up' do
  "Sign up page"
  erb :create_new_user
end

get '/sign_up/email_taken' do
  "Email is taken, try again"
  erb :email_taken
end

post '/sign_up' do
  "Sign up now we have email and password values"

  #Look up if email is in database
  find_email = find_email_taken(params["email"])
  if find_email.any?
    redirect '/sign_up/email_taken'
  else
  create_user(params["email"], params["password_digest"])
  redirect "/"
end

get '/sign_up/email_taken'
  "Email is taken, try again"
  erb :email_taken
end

get '/my_cards' do
  "My cards page"
  user = find_user_by_id(session[:user_id])
  cards = find_card_by_user_id(session[:user_id])

  erb :my_cards, locals: {
    user: user,
    cards: cards
  }
end

get '/template' do
  "Card template"
  erb :template
end

