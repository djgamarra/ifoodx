class UsersController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def signin
  end

  def login
    @user = User.new first_name: 'hola bb'
  end
end
