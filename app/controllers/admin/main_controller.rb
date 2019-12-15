class Admin::MainController < BaseAdminController
    before_action :admin_authorization, except: [:index]

    def index
        #Reservation graph
        resCounts = Reservation.where("created_at > ?", 1.week.ago).group("room_id").count
        
        @rooms = Room.all.to_a.map(&:serializable_hash)
        @rooms.map{|x| x[:res_count] = (resCounts[x["id"]].nil? ? 0 : resCounts[x["id"]])}
        @rooms = JSON.parse(@rooms.to_json, object_class: OpenStruct)
        @barsChart = @rooms.collect{|x| {name: x.name, resCount: x.res_count}}

        #Widgets
        @userCount = User.count
        @memberCount = User.where(is_member: true).count
        @reservationCount = Reservation.count
        tmpBudget = Budget.all.to_a
        income = tmpBudget.select{|x| x.budget_type == "Income"}.inject(0){|sum, x| sum + x.amount}
        expense = tmpBudget.select{|x| x.budget_type == "Expense"}.inject(0){|sum, x| sum + x.amount}
        @totalBudget = income - expense

        #DB Usage        
        @coreEntries = Budget.count + Event.count + FacultyLesson.count + LessonSchedule.count + Manager.count + Teacher.count + Room.count
        @userCount = User.count
        @scoutRelated = Instrument.count + MusicianInfo.count + ScoutProfile.count
        @reservationCount = Reservation.count
        @banCount = BannedUser.count
        @sessionCount = Session.count

        #Board members, Top reservations, Budget summary
        @topReservations = User.connection.select_all("select u.name, count(r.id) as rcount from users u inner join reservations r on u.id = r.user_id group by u.id order by rcount desc limit 10;")
        @topReservations.to_hash
        @topReservations = JSON.parse(@topReservations.to_json, object_class: OpenStruct)

        @boardMembers = User.where(is_yk: true).to_a

        @budgetSummary = Budget.select("amount, reason, budget_type").order("created_at DESC").take(10)
        
        #Last reservations
        @reservations = Reservation.order("start_at DESC").take(15).to_a.map(&:serializable_hash)
        users = User.all.to_a
        rooms = Room.all.to_a
        
        @reservations.each do |reservation|
            reservation[:user] = users.select{|x| x.id == reservation["user_id"]}.first
            reservation[:room] = rooms.select{|x| x.id == reservation["room_id"]}.first  
        end
        @reservations = JSON.parse(@reservations.to_json, object_class: OpenStruct)
        p @reservations[0]
    end

    def reservations
        reservations = Reservation.where("start_at < ?", Time.now.beginning_of_day - 1.month.ago)

        reservations.destroy_all
        
        render json: {reservationCount: Reservation.count}
    end

    def user_data
    end

    def ban_info
    end

    def sessions
        sessions = Session.where("created_at < ?", 1.week.ago)
        
        sessions.destroy_all

        render json: {sessionCount: Session.count}
    end
end