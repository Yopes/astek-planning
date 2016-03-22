# -*- coding: utf-8 -*-
class InvitationsController < ApplicationController
  before_action :redirect_not_admin

  def new
  end

  def create
    invitation = Invitation.new(mail: params[:mail])
    if invitation.save
      InvitationMailer.invitation_mailer(invitation).deliver_now
      flash.now['success'] = "Invitation envoyé"
    else
      flash.now['alert'] = "Erreur lors de l'invitation"
    end
    render 'new'
  end

end
