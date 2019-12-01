class Api::AuthenticationController < ApiController
    skip_before_action :authenticate_request
   
    def authenticate
      command = AuthenticateUser.call(params[:token])
   
      if command.success?
        render json: { auth_token: command.result }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end
end