class Api::RoomsController < ApiController
    def index
        response = ApiModels::BaseApiResponse.new

        rooms = Room.all.collect{|x| x.parse_response}

        response.data = rooms

        render json: response
    end

    def show
        response = ApiModels::BaseApiResponse.new

        room = Room.where(id: params[:id]).first
        if room.nil?
            render json: {}, status: :not_found
            return
        end

        managers = room.parse_response[:managers]

        schedules = room.lesson_schedules
        .group_by(&:weekday)
        .collect{|key, val| {
            weekday: key, 
            lessons: val.sort_by{|x| x.start_at}.collect{|x| {
                lesson: x.faculty_lesson.name,
                startAt: x.start_at,
                endAt: x.end_at
            }}
        }}

        response.data = room.attributes.merge!({managers: managers, room_schedule: schedules})
        
        render json: response
    end
end