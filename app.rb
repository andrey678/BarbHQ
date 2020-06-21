require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base
	validates :name, presence: true, length: { minimum:3 }
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true 
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
	validates :clientemail, presence: true
	validates :clientmessage, presence: true
end
before do
@barbers = Barber.all
end


get '/' do
	
	erb :index
end

get '/visit' do
	@c = Client.new
	@b =  Barber.new
	erb :visit
end

post '/visit' do

	@c = Client.new 	params[:client]
	@b = Barber.new 	params[:barber]
	if @c.save && @c.save
	erb "<h2>Спасибо, вы записались!</h2>"
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end
end

get '/barber/:id' do
	@barber = Barber.find params[:id]
	erb :barber
end

get '/bookings' do
  @clients = Client.order ('created_at DESC') 
  erb :bookings
end

get '/client/:id' do
	@client = Client.find (params[:id])
	erb :client
end	

get '/contacts' do
	@d = Contact.new
		erb :contacts
end
post '/contacts' do
	@d = Contact.new params[:contact]

	if @d.save
	
	erb "<h2>Спасибо за обращение.С вами свяжутся в ближайшее время!</h2>"
	
	else
		@error = @d.errors.full_messages.first
		erb :contacts
end
end