require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do
    erb :new
  end

  get '/posts/:id' do
    id = params[:id].to_i
    begin
      @post = Post.find(id)
      erb :show
    rescue
      redirect '/posts'
    end
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  post '/posts' do
    @post = Post.create(params)
    redirect '/posts'
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.update(params.slice("name", "content"))
    erb :show
  end

  delete '/posts/:id' do
    @post = Post.find(params[:id])
    @post.destroy
    "#{@post.name} was deleted"
  end

end
