class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(name: params[:user][:name], mail: params[:user][:mail])
  end

  def show
    @users = User.where(id: params[:id])
  end

  def update
    @user = User.find(params[:id])
  end

  def destroy
    User.where(id: params[:id]).delete_all
    @id = params[:id]
  end

end
