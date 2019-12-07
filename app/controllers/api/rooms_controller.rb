class Api::RoomsController < ApiController
    def index
        response = ApiModels::BaseApiResponse.new

        rooms = Room.all.collect{|x| x.parse_response}

        response.data = rooms

        render json: response
    end
end