namespace :reserve do
	task :gitar_dersi => :environment do
		if Time.now.wday==6 #just in case it's not saturday
			tuesday=Time.now+3.days
			thursday=Time.now+5.days
			
			tuesday_start_date=Time.parse("#{tuesday.strftime('%F')} 17:00")
			tuesday_end_date=tuesday_start_date+5.hours

			thursday_start_date=Time.parse("#{thursday.strftime('%F')} 14:00")
			thursday_end_date=thursday_start_date+8.hours

			TuesdayRes=Reservations.new(user_id: 364,room_id: 2,start_date: tuesday_start_date,end_date:tuesday_end_date,info:"Gitar Dersi",hour:5)
			TuesdayRes.save

			ThursdayRes=Reservations.new(user_id: 364,room_id: 2,start_date: thursday_start_date,end_date:thursday_end_date,info:"Gitar Dersi",hour:8)
			ThursdayRes.save
		end
		puts 'gitar dersi Success'
	end

	task :davul_odasi=> :environment do
		
		monday=Time.now+2.days
		monday_start_date=Time.parse("#{monday.strftime('%F')} 10:30")
		monday_end_date=monday_start_date+10.hours
		MondayRes=Reservations.new(user_id: 364,room_id: 1,start_date: monday_start_date,end_date:monday_end_date,hour: 10)
		MondayRes.save
		
		tuesday=Time.now+3.days
		tuesday_start_date=Time.parse("#{tuesday.strftime('%F')} 10:30")
		tuesday_end_date=tuesday_start_date+10.hours
		TuesdayRes=Reservations.new(user_id:364,room_id: 1,start_date:tuesday_start_date,end_date:tuesday_end_date,hour:10 )
		TuesdayRes.save
		
		thursday=Time.now+5.days
		thursday_start_date=Time.parse("#{thursday.strftime('%F')} 10:30")
		thursday_end_date=thursday_start_date+10.hours
		ThursdayRes=Reservations.new(user_id:364,room_id:1,start_date: thursday_start_date,end_date:thursday_end_date,hour:10)
		ThursdayRes.save
		
		friday=Time.now+6.days
		friday_start_date=Time.parse("#{friday.strftime('%F')} 10:30")			
		friday_end_date=friday_start_date+6.hours
		FridayRes=Reservations.new(user_id:364,room_id:1,start_date: friday_start_date,end_date:friday_end_date,hour:6)
		FridayRes.save
		puts 'davul odası Success'
	end

	task :san_odasi => :environment do
		
		wednesday=Time.now+4.days
		wednesday_start_date=Time.parse("#{wednesday.strftime('%F')} 10:00")
		wednesday_end_date=wednesday_start_date+7.hours
		WednesdayRes=Reservations.new(user_id:364,room_id: 5,start_date:wednesday_start_date,end_date:wednesday_end_date,hour:7)
		puts 'San odası Success'
	end

task :reserve_all =>[:gitar_dersi,:davul_odasi,:san_odasi] 
end

