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
        uri = URI("https://oauth2.googleapis.com/tokeninfo?id_token=#{token}")
        response = Net::HTTP.get(uri)
        authResponse = JSON.parse(response)
        
        hd = authResponse["hd"]
        if hd == "sabanciniv.edu"
            uid = authResponse["sub"]
            user = User.where(uid: uid).first
            
            email = authResponse["email"]
            user = User.where(email: email).first
            if user
                user.update(
                    provider: "google_oauth2",
                    uid: uid,
                    name: authResponse['name'].split(' (Student)')[0]
                )
                return user
            end

            user = User.create(
                provider: "google_oauth2",
                uid: uid,
                name: authResponse['name'].split(' (Student)')[0],
                email: email,
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