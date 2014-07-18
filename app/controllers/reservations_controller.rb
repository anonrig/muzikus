class ReservationsController < ApplicationController
  before_action :set_rights

  def set_rights
    if (current_user)
      if (current_user.sabancimail)
        if (Muzikususers.where('email = ?', current_user.sabancimail).count == 0)
          redirect_to root_path
        end
      else
        redirect_to mail_path
      end
    end
  end

  def index
    if current_user
      @all = Reservations.where("start_date > ?", Time.now.beginning_of_day - 6.hours).order("start_date ASC")
    else
      redirect_to root_path
    end
  end

  def show

  end

  def new
    if current_user
      @reservation = Reservations.new
      #@currentUser = Muzikususers.find(current_user.id)
      @currentUser = Muzikususers.where("email = ?", current_user.sabancimail).first
      
      if !@currentUser
      	redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end
  
  def delete
  	@current = Reservations.find(params[:id])
	if current_user
		if @current.user_id == current_user.id && @current.end_date > Time.now
			@current.destroy!
			redirect_to reservation_path
		else
			redirect_to reservation_path
		end
	else
		edirect_to reservation_path
	end
  end

  def create
	  respond_to do |format|

	    newRes = Reservations.new
	    newRes.user_id = session[:user_id]
	    newRes.room_id = params['reservations']['room_id']
	    newRes.start_date = Time.parse("#{params['whichDay']} #{params['startHour']}")
	      
	    onlyHour = params['startHour'].split(':')[0].to_i
	    
	    newRes.end_date = newRes.start_date + params['hourCount'].to_i.hours
	    newRes.info = params['reservations']['info']
	    newRes.hour = params['hourCount']
	    
		allReservationsOnThatDay = Reservations.where('start_date BETWEEN ? AND ?', newRes.start_date.in_time_zone(3).beginning_of_day, newRes.start_date.in_time_zone(3).end_of_day).where("room_id = ?", newRes.room_id)
		
		isValid = true
		
		allReservationsOnThatDay.each do |item|
			#newRes -> rezervasyon almak istedigim saat
			#item -> veritabaninda olan
			if (newRes.start_date >= item.start_date && newRes.start_date < item.end_date)
				# tam ortasinda demek
				isValid = false
			elsif (newRes.end_date < item.end_date && newRes.end_date > item.start_date)
				# bitis zamani mevcut olan rezervasyonun tam ortasinda bitiyor demek
				isValid = false
			elsif (newRes.start_date < item.start_date && newRes.end_date > item.end_date)
				# mevcut rezervasyondan once basliyor, sonra bitiyor.
				isValid = false
			elsif (newRes.end_date == item.end_date)
				# eger rezervasyon bitis zamanlari ayniysa.
				isValid = false
			end
		end
		
		if (isValid)
		    allRes = Reservations.where('start_date BETWEEN ? AND ?', newRes.start_date.beginning_of_day, newRes.start_date.end_of_day).where("user_id = ?", session[:user_id]).where("room_id = ?", newRes.room_id).sum(:hour)
		
		    if (allRes.to_i + params['hourCount'].to_i) > 3
		      # bir gun de maksimum 3 saat rezervasyon yapabilir bir kullanici
		      format.json { render :json => "hourcount"}
		    else
		      newRes.save
		      format.json { render :json => "reservation"}
		    end
		else
			format.json {render :json => "occupiedreservation"}
		end
			
    end
  end
  
  def update

  end
end
