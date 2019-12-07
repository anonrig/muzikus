class Api::AccountController < ApiController
    def get
        response = ApiModels::BaseApiResponse.new
        response.data = current_user
        render json: response
    end
end