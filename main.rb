require 'sinatra'
require 'sinatra/reloader'

require_relative 'models/card.rb'
also_reload 'models/card.rb'

get '/' do

  cards = find_all_cards

  erb :index, locals: { cards: cards}
end

#Create card form
get '/create_new_card' do
  erb :create_new_card
end

#Card ID Details
get '/cards/:id' do
  card = find_card_by_id(params["id"])

  erb :card_details, locals: { card: card }
end

get '/about' do
  "I am the about page"
  erb :about
end

get '/donations' do
  "I am the donations page"
  erb :donations
end

#Make card
post '/cards' do
  create_card(params["title"], params["attack"], params["health"], params["rarity"], params["text_description"], params["cost"], params["image_url"])

  latest_card = find_latest_card_id(params["id"])
  redirect '/cards/id'
  erb locals: { latest_card: latest_card }
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