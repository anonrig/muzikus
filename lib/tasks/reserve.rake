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
		puts 'Success'
	end
end
