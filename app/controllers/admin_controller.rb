class AdminController < ApplicationController
  def users
	  if current_user
	  	if (Muzikususers.where("email = ?", current_user.sabancimail).first.ismyk == true)
	  		@member = Muzikususers.where("email = ?", current_user.sabancimail).first
		  	if (@member)
		  		if (@member.ismyk == true)
				  	@muzikusMembers = Muzikususers.all.order("email ASC")
				  	@newMember = Muzikususers.new
				  	@mykMembers = Muzikususers.where("ismyk = ? ", true)
				  	@topReserve = Reservations.limit(10).group("user_id").count
            @bloggers   = Muzikususers.where("isblogger=?",true)
				  end
			  end
		  end
	 end
  end

  def muzikus
  	if current_user
	  	if (Muzikususers.where("email = ?", current_user.sabancimail).first.ismyk == true)
  			@allUsers = Users.all.order("created_at DESC")
  		else
  			redirect_to root_path
  		end
  	else
  		redirect_to root_path
  	end
  end

  def createuser

  	@new = Muzikususers.new
  	@new.sid = params['muzikususers']['sid']
  	@new.email = params['muzikususers']['email']
  	@new.ismyk = params['muzikususers']['ismyk']
  	@new.isyk = params['muzikususers']['isyk']
  	@new.isdavul = params['muzikususers']['isdavul']
  	@new.isworkshop = params['muzikususers']['isworkshop']

  	if (!@new.sid.blank? && !@new.email.blank?	)
  	  @new.save
	end
  	redirect_to admin_users_path
  end

  def deleteuser
	if current_user
	  	@new = Muzikususers.find(params['muzikususers']['userid'])
	  	@new.destroy
	  	redirect_to admin_users_path
  	end
  end

  def edit
  	if current_user
  		@current = Muzikususers.find(params['id'])
  	end
  end

  def editSubmit
  	if (current_user)
  		@current = Muzikususers.where("email = ?", params['muzikususers']['email']).first
  		@current.email = params['muzikususers']['email']
  		@current.isyk = params['muzikususers']['isyk']
  		@current.ismyk = params['muzikususers']['ismyk']
  		@current.isdavul = params['muzikususers']['isdavul']
  		@current.isworkshop = params['muzikususers']['isworkshop']
      @current.isblogger=params['muzikususers']['isblogger']
  		@current.save
  		redirect_to admin_users_path
  	else
  		redirect_to root_path
  	end
  end

  def budget
	  if current_user
	  	if (Muzikususers.where("email = ?", current_user.sabancimail).first.ismyk == true)
		  	@newBudget = Budget.new
		  	@allBudgets = Budget.all.order("created_at DESC")
		  	@totalBudget = 0
		  	@allBudgets.each do |item|
		  		if (item.budget_type == "income")
		  			@totalBudget += item.amount.to_i
		  		else
		  			@totalBudget -= item.amount.to_i
		  		end
		  	end
		  end
	  end
  end

  def addbudget
  	if (Muzikususers.where("email = ?", current_user.sabancimail).first.ismyk == true)
	  	@newBudget = Budget.new
	  	@newBudget.user_id = current_user.id
	  	@newBudget.budget_type = params['budget']['budget_type']
	  	@newBudget.amount = params['budget']['amount']
	  	@newBudget.reason = params['budget']['reason']
	  	@newBudget.save

	  	redirect_to admin_budget_path
  	end
  end

  def support
	  if current_user
	  	if (Muzikususers.where("email = ?", current_user.sabancimail).first.ismyk == true)
	  		@allSupports = Support.all.order("created_at DESC")

	  	end
	  end
  end

  def supportdelete
	  if current_user
	  	if (Muzikususers.where("email = ?", current_user.sabancimail).first.ismyk == true)
		  	@new = Support.find(params['support']['id'])
		  	@new.destroy
		  	redirect_to admin_support_path
	  	end
  	end
  end

  def log
  	if current_user
  		if (Muzikususers.where("email = ?", current_user.sabancimail).first.ismyk == true)
  			@logs = Reservations.order("start_date DESC").limit(200)
  		end
  	end
  end

end
