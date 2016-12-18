namespace :reserve do
	#380 -> ozkan okan
	muzikus_id=364
	
	task :hangar => :environment do 
			hangar_id=6
			if Time.now.wday==6
		#1
			tuesday=Time.now+3.days
			tuesday_start_date=Time.parse("#{tuesday.strftime('%F')} 17:00")
			duration=3
			tuesday_end_date=tuesday_start_date+duration.hours
			TuesdayRes=Reservations.new(user_id: muzikus_id,room_id: hangar_id,start_date: tuesday_start_date,end_date:tuesday_end_date,info:"Proje",hour:duration)
			TuesdayRes.save
		#2
			wednesday=Time+4.days
			wednesday_end_date=Time.parse("#{wednesday.strftime('%F')} 17:00")
			duration=3
			wednesday_end_date=wednesday_start_date+duration.hours
			WednesdayRes=Reservations.new(user_id: muzikus_id,room_id:hangar_id,start_date: wednesday_start_date,end_date:wednesday_end_date,info:"Proje",hour:duration)
			WednesdayRes.save
		#3	
		friday=Time.now+6.days
		friday_start_date=Time.parse("#{friday.strftime('%F')} 13:00")
		duration=2
		friday_end_date=friday_start_date+duration.hours
		FridayRes=Reservations.new(user_id: muzikus_id,room_id:hangar_id,start_date: friday_start_date,end_date:friday_end_date,info:"Proje",hour:duration)
		FridayRes.save	
			else
			puts "it's not saturday"
			end
	end

	


task :reserve_all =>[:hangar] 
end

