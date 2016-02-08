class MainController < ApplicationController
require 'flickraw'

  def index
    if current_user
      if current_user.sabancimail 
        if Muzikususers.where('email = ?', current_user.sabancimail).count > 0
          render "registered"
        else
          render "notregistered"
        end
      else
        render "registered"
      end
    end
  end

  def mail
    # screen for the user to input the sabanci university email adress
    if (current_user.sabancimail != nil)
      redirect_to root_path
    end
  end

  def createmail
    @user = current_user
    emailadress = params['users']['sabancimail']
	isAlreadyRegistered = false
	
    Users.all.each do |item|
      if item.sabancimail == emailadress
		isAlreadyRegistered = true
        redirect_to mail_path
      end
    end
    
    if (isAlreadyRegistered)
		return    
	end

    if (emailadress.length > 0 && emailadress.include?("@sabanciuniv.edu"))
      @user.sabancimail = emailadress
      @user.save!
      redirect_to root_path
    else
      redirect_to mail_path
    end
  end

  def contactus
    @newSupport = Support.new
  end

  def contactsubmit
    @newSupport = Support.new
    @newSupport.name = params['support']['name']
    @newSupport.email = params['support']['email']
    @newSupport.subject = params['support']['subject']
    @newSupport.message = params['support']['message']
    
    AdminMailer.contact_email(@newSupport.name, @newSupport.email, @newSupport.subject, @newSupport.message).deliver

    respond_to do |format|
      if @newSupport.save
        format.html { redirect_to contactus_path, notice: 'Contact form was successfully submitted.' }
      else
        format.html { render action: 'contactus' }
      end
    end
  end

  def howto
  end

  def system
  end

  def aboutus
  end

  def registered
    #if user's email is listed in muzikus user list
  end

  def notregistered
    #if user's email is not listed
  end
  
  def events
  end
  
  def faculty
  end
  
  def rooms
  end
  
  def projects
  end
  
  def bands
  end
  
  def gallery
  @popular=::Instagram.user_recent_media('1702172116')
  end


  
  def faq
  end
end
