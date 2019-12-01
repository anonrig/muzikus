class AuthenticateUser
    prepend SimpleCommand
  
    def initialize(token)
      @token = token
    end
  
    def call
      JsonWebToken.encode(user_id: user.id) if user
    end
  
    private
  
    attr_accessor :token
  
    def user
        # Authorize token with google...
        param = {
            id_token: token
        }
        response = Net::HTTP.get_response("https://oauth2.googleapis.com","/tokeninfo?id_token=#{token}")
        authResponse = JSON.parse(response.body)
        hd = authResponse["hd"]
        if hd == "sabanciniv.edu"
            uid = authResponse["sub"]
            user = User.where(uid: uid).first
            return user if user
            
            user = User.create(
                provider: "google_oauth2",
                uid: uid,
                name: authResponse['name'].split(' (Student)')[0],
                email: authResponse['email'],
                is_member: false,
                is_yk: false,
                is_myk: false,
                is_workshop: false,
                is_drum: false
            )
            return user
        end
        
        
        errors.add :user_authentication, 'invalid token'
        nil
    end
end