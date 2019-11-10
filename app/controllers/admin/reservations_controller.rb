class Admin::ReservationsController < BaseAdminController
    def index
        @reservations = Reservation.all.to_a.map(&:serializable_hash)
        users = User.all.to_a
        rooms = Room.all.to_a
        
        @reservations.each do |reservation|
            reservation[:user] = users.select{|x| x.id == reservation["user_id"]}.first
            reservation[:room] = rooms.select{|x| x.id == reservation["room_id"]}.first  
        end
        @reservations = JSON.parse(@reservations.to_json, object_class: OpenStruct)

        # Pagination
        @currentPage = params["page"].to_i
        if @currentPage == 0 then @currentPage = 1 end
        
        @pageCounter = 25
        @totalCount = @reservations.count
        
        @pageCount = @totalCount / @pageCounter
        if ((@totalCount % @pageCounter) > 0)
            @pageCount = @pageCount + 1
        end
        
        @reservations = @reservations.drop(@currentPage * @pageCounter - @pageCounter).take(@pageCounter)
    end
end