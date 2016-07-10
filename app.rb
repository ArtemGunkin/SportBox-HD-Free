require 'sinatra'
require 'httparty'
require 'json'
require 'slim'

get '/' do
  response = HTTParty.get('http://news.sportbox.ru/api2/rubricvideo?term_id=7212&page_number=1&app_id=android%2F3&page_size=30&node_icon_preset=190x160')
  @nodes = JSON.parse(response.body)['nodes']
  slim :index
end

get '/stream' do
  id = params[:id]
  response = HTTParty.get("http://news.sportbox.ru/api2/videostream?id=#{id}&app_id=android%2F3")
  body = JSON.parse(response.body)
  if body['streams']['message']
    body['streams']['message']
  else
    @url = body['streams']['url']
    slim :stream
  end
end
