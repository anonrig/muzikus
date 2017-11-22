namespace :reserve do
	#380 -> ozkan okan
	#DB'de olanın 3 saat fazlası görünüyor viewda. Burada saat doğru ama
	muzikus_id=364
	
	task :hangar => :environment do 
			hangar_id=6
			if Time.now.wday==3
		#1
			monday=Time.now+2.days
			monday_start_date=Time.parse("#{monday.strftime('%F')} 20:00")
			duration=3
			monday_end_date=monday_start_date+duration.hours
			mondayRes=Reservations.new(user_id: muzikus_id,room_id: hangar_id,start_date: monday_start_date,end_date:monday_end_date,info:"KoroSU",hour:duration)
			mondayRes.save
		#2
			tuesday=Time.now+3.days
			tuesday_start_date=Time.parse("#{tuesday.strftime('%F')} 20:00")
			duration=3
			tuesday_end_date=tuesday_start_date+duration.hours
			tuesdayRes=Reservations.new(user_id: muzikus_id,room_id: hangar_id,start_date: tuesday_start_date,end_date:tuesday_end_date,info:"Ensemble",hour:duration)
			tuesdayRes.save
		#2
			wednesday=Time.now+4.days
			wednesday_start_date=Time.parse("#{wednesday.strftime('%F')} 20:00")
			duration=3
			wednesday_end_date=wednesday_start_date+duration.hours
			wednesdayRes=Reservations.new(user_id: muzikus_id,room_id:hangar_id,start_date: wednesday_start_date,end_date:wednesday_end_date,info:"Ömeritus",hour:duration)
			wednesdayRes.save
		
			else
			puts "it's not saturday"
			end
	end

	task :piyano_dersi => :environment do
			piyano_odasi_id=3
			if Time.now.wday==6
		#pazartesi 8:30-19:30	
			monday=Time.now+2.days
			monday_start_date=Time.parse("#{monday.strftime('%F')} 8:30")
			duration=11
			monday_end_date=monday_start_date+duration.hours
			mondayRes=Reservations.new(user_id: muzikus_id, room_id: piyano_odasi_id, start_date: monday_start_date, end_date: monday_end_date, info:"Piyano Dersi", hour: duration)
			mondayRes.save
		#sali 8:30-19:30	
			tuesday=Time.now+3.days
			tuesday_start_date=Time.parse("#{tuesday.strftime('%F')} 8:30")
			duration=11
			tuesday_end_date=tuesday_start_date+duration.hours
			tuesdayRes=Reservations.new(user_id: muzikus_id, room_id: piyano_odasi_id, start_date: tuesday_start_date, end_date: tuesday_end_date, info:"Piyano Dersi", hour: duration)
			tuesdayRes.save
		#çarşamba 8:30 - 19:30
			wednesday=Time.now+4.days
			wednesday_start_date=Time.parse("#{wednesday.strftime('%F')} 8:30")
			duration=11
			wednesday_end_date=wednesday_start_date+duration.hours
			wednesdayRes=Reservations.new(user_id: muzikus_id, room_id: piyano_odasi_id, start_date: wednesday_start_date, end_date: wednesday_end_date,info:"Piyano Dersi",hour: duration)
			wednesdayRes.save
		#perşembe 8:40 - 19:30
			thursday=Time.now+5.days
			thursay_start_date=Time.parse("#{thursday.strftime('%F')} 8:30")
			duration=11
			thursday_end_date=thursday_start_date+duration.hours
			thursdayRes=Reservations.new(user_id: muzikus_id, room_id: piyano_odasi_id,start_date: thursday_start_date, end_date: thursday_end_date,info:"Piyano Dersi",hour: duration)
			thursdayRes.save
			else
			puts "it's not saturday"
			end
	end
		
	task :san_odasi => :environment do 
			san_odasi_id=5
			if Time.now.wday==6
		#1
			monday=Time.now+2.days
			monday_start_date=Time.parse("#{monday.strftime('%F')} 11:30")
			duration=7
			monday_end_date=monday_start_date+duration.hours
			mondayRes=Reservations.new(user_id: muzikus_id,room_id: san_odasi_id,start_date: monday_start_date,end_date:monday_end_date,info:"Şan Dersi",hour:duration)
			mondayRes.save
		#2
			wednesday=Time.now+4.days
			wednesday_start_date=Time.parse("#{wednesday.strftime('%F')} 11:30")
			duration=7
			wednesday_end_date=wednesday_start_date+duration.hours
			wednesdayRes=Reservations.new(user_id: muzikus_id,room_id:san_odasi_id,start_date: wednesday_start_date,end_date:wednesday_end_date,info:"Şan Dersi",hour:duration)
			wednesdayRes.save
		
			else
			puts "it's not saturday"
			end
	end
	
	task :davul_dersi => :environment do
			davul_odasi_id=1
			if Time.now.wday==6
		#pazartesi 10:30-19:30	
			monday=Time.now+2.days
			monday_start_date=Time.parse("#{monday.strftime('%F')} 10:30")
			duration=9
			monday_end_date=monday_start_date+duration.hours
			mondayRes=Reservations.new(user_id: muzikus_id, room_id: davul_odasi_id, start_date: monday_start_date, end_date: monday_end_date, info:"Davul Dersi", hour: duration)
			mondayRes.save
		#sali 10:30-19:30	
			tuesday=Time.now+3.days
			tuesday_start_date=Time.parse("#{tuesday.strftime('%F')} 10:30")
			duration=9
			tuesday_end_date=tuesday_start_date+duration.hours
			tuesdayRes=Reservations.new(user_id: muzikus_id, room_id: davul_odasi_id, start_date: tuesday_start_date, end_date: tuesday_end_date, info:"Davul Dersi", hour: duration)
			tuesdayRes.save
		#perşembe 10:30 - 19:30
			thursday=Time.now+5.days
			thursay_start_date=Time.parse("#{thursday.strftime('%F')} 10:30")
			duration=9
			thursday_end_date=thursday_start_date+duration.hours
			thursdayRes=Reservations.new(user_id: muzikus_id, room_id: davul_odasi_id,start_date: thursday_start_date, end_date: thursday_end_date,info:"Davul Dersi",hour: duration)
			thursdayRes.save
			else
			puts "it's not saturday"
			end
	end


task :reserve_all =>[:hangar,:piyano_dersi, :san_odasi, :davul_dersi] 
end