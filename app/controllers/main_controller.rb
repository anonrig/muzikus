class MainController < ApplicationController
  def index
    if current_user
      if current_user.is_member
          render "registered"
      else
        render "notregistered"
      end
    end
  end

  def aboutus
  end

  def contactus
  end

  def projects
  end

  def bands
  end

  def gallery
    @popular=::Instagram.user_recent_media('1702172116')
  end

  def howto
  end
  
end
