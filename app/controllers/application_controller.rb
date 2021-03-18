require 'pry'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/articles'
  end

  #create
  get '/articles/new' do
    @article = Article.new
    # redirect to '/articles'
    erb :new
  end

  #read
  get '/articles' do
    @articles = Article.all
    # binding.pry
    erb :index
  end

  #create

  post '/articles' do 
    # binding.pry
    @article = Article.create(title: params[:title], content: params[:content])
    redirect to "/articles/#{@article.id}"
    erb :new
   
  end
  #read
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{@article.id}"
  end

  delete '/articles/:id' do 
    Article.delete(params[:id])
    redirect to "/articles"
  end

end