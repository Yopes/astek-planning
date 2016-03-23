# -*- coding: utf-8 -*-
require 'json'

class UsersController < ApplicationController
  before_action :redirect_not_connected, except: [:new, :create]
  before_action :redirect_not_admin, only: [:delete]

  def index
    @users = User.all
  end

  def new
    redirect_to root_path if signed_in?
  end

  def create
    redirect_to root_path if signed_in?
    invitation = JSON.parse(params[:invitation].gsub(/:([a-zA-z]+)/,'"\\1"').gsub('=>', ': '))
    token = invitation.symbolize_keys[:value]
    if user_params[:password] == params[:password_verification] and
        Invitation.find_by_token(token) and User.new(user_params).save
      Invitation.find_by_token(token).delete
      flash['success'] = 'Succès lors de la création du nouvel utilisateur'
      redirect_to root_path
    else
      flash.now['alert'] = 'Erreur lors de la création de l\'utilisateur'
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    check_user_access @user
  end

  def update
    user = User.find(params[:id])
    check_user_access user
    if !user.nil? &&
        (params[:password].nil? || params[:password].empty? ||
         params[:password] == params[:password_verification])
      if user.update(user_params)
        flash[:success] = "User successfuly updated"
        redirect_back
        return
      end
    end
    flash[:alert] = "Can't update user"
    redirect_back
  end

  def delete
    user = User.find(params[:id])
    if !user.nil?
      user.jobs.each do |job|
        job.destroy
      end
      user.destroy
    end
    redirect_back
  end

  def search_users
    users = []
    User.where("login LIKE '%#{params[:login]}%'").select('login').limit(100).each do |user|
      users << user.login
    end
    render json: users, callback: params['callback']
  end

  private

  def user_params
    if !admin?
      params[:user][:admin] = nil
      params[:user][:actif] = nil
    end
    params.require(:user).permit(:login, :firstname, :lastname, :mail, :tel, :promo, :password, :admin, :actif)
  end

  def check_user_access(user)
    redirect_not_admin if user != current_user
  end

end
