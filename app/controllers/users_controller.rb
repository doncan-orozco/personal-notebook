# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    render Users::IndexView.new(users: User.all)
  end

  def show
    render Users::ShowView.new(user: @user)
  end

  def new
    render Users::NewView.new
  end

  def edit
    render Users::EditView.new(user: @user)
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: t(".notice") }
      else
        format.html { render Users::NewView.new(user: @user), status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: t(".notice") }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: t(".notice") }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :full_name, :username, :bio)
  end
end
