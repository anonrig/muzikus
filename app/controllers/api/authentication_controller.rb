class Api::AuthenticationController < ApiController
    skip_before_action :authenticate_request
   
    def authenticate
      response = ApiModels::BaseApiResponse.new
      command = AuthenticateUser.call(params[:token])
   
      if command.success?
        response.data = {
          auth_token: command.result 
        }
        render json: response
      else
        response.setMessage command.errors
        render json: response, status: :unauthorized
      end
    end
end