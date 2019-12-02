class Api::ReservationsController < ApiController
    def index
        response = ApiModels::BaseApiResponse.new

        reservations = Reservation.where("start_at > ?", Time.now.beginning_of_day - 3.hours).order('start_at ASC')
        response.data = reservations.collect{|x| 
            {
                id: x.id,
                owner: User.find(x.user_id).parse_response,
                room: Room.find(x.room_id).parse_response,
                startDate: x.start_at,
                endDate: x.end_at,
                details: x.detail
            }
        }.to_a
        render json: response
    end

    def show
    end
end