require 'sinatra'
require 'net/http'
require 'json'

get '/' do
  erb :index, layout: :application_layout
end

## People

get '/people' do
  response = get_all("people")
  people = response.fetch(:results, [])

  erb :"people/index", layout: :application_layout, locals: { people: people }
end

get '/people/:id' do
  person = get_person(params[:id])

  erb :"people/show", layout: :application_layout, locals: { person: person }
end

## Planets

get '/planets' do
  response = get_all("planets")
  planets = response.fetch(:results, [])

  erb :"planets/index", layout: :application_layout, locals: { planets: planets }
end

get '/planets/:id' do
  planet = get_planet(params[:id])

  erb :"planets/show", layout: :application_layout, locals: { planet: planet }
end

## Films

get '/films' do
  response = get_all("films")
  films = response.fetch(:results, [])

  erb :"films/index", layout: :application_layout, locals: { films: films }
end

get '/films/:id' do
  film = get_film(params[:id])

  erb :"films/show", layout: :application_layout, locals: { film: film }
end

## Helpers

helpers do
  def get_all(resource)
    response = Net::HTTP.get(URI.parse("https://swapi.dev/api/#{resource}/"))

    JSON.parse(response, symbolize_names: true)
  end

  def get_resource(resource, id)
    response = Net::HTTP.get(URI.parse("https://swapi.dev/api/#{resource}/#{id}"))

    person = JSON.parse(response, symbolize_names: true)
    person.merge(id: id)
  end

  def get_person(id)
    get_resource("people", id)
  end

  def get_planet(id)
    get_resource("planets", id)
  end

  def get_film(id)
    get_resource("films", id)
  end

  def get_film_from_url(url)
    id = url.split('/').last
    response = Net::HTTP.get(URI.parse(url))

    film = JSON.parse(response, symbolize_names: true)
    film.merge(id: id)
  end

  def get_person_slow(id)
    sleep(2)
    get_person(id)
  end
end

