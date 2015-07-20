# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require './models/player.rb'

enable :sessions

helpers do
  def title
    if @title
      "#{@title}"
    else
      "Welcome."
    end
  end
end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

# get ALL players
get "/" do
  @players = Player.order("created_at DESC")
  @title = "Welcome."
  erb :"players/index"
end

# create new player
get "/players/create" do
  @title = "Create player"
  @player = Player.new
  erb :"players/create"
end

post "/players" do
  @player = Player.new(params[:player])
  if @player.save
    redirect "players/#{@player.id}", :notice => 'Congrats! Player created. (This message will disapear in 4 seconds.)'
  else
    redirect "players/create", :error => 'Something went wrong. Try again. (This message will disapear in 4 seconds.)'
  end
end

# view player
get "/players/:id" do
  @player = Player.find(params[:id])
  @title = @player.name
  erb :"players/view"
end

put "/players/:id" do
  @player = Player.find(params[:id])
  @player.update(params[:player])
  redirect "/players/#{@player.id}"
end

# edit player
get "/players/:id/edit" do
  @player = Player.find(params[:id])
  @title = "Edit Form"
  erb :"players/edit"
end