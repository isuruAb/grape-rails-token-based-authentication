module V1
    class Auth < Grape::API

      format :json
      prefix :api
      resource :auth do

        desc "Creates and returns access_token if valid login"
        params do
          requires :name, type: String, desc: "Username or email address"
          requires :password, type: String, desc: "Password"
        end
        post :login do
          user = User.find_by_name(params[:name].downcase)
          apikey=ApiKey.find_by_user_id(user.id)
          if apikey && !apikey.expired?
            {token:ApiKey.find_by_user_id(user.id).access_token}
          elsif user && user.authenticate(params[:password])
            key = ApiKey.create(user_id: user.id)
            {token: key.access_token}
          else
            error!('Unauthorized.', 401)
          end
        end
      
        desc "Returns pong if logged in correctly"
        params do
          #requires :token, type: String, desc: "Access token."
        end
        get :ping do   
          if "Bearer"!=/Bearer/.match(headers['Authorization'])[0]
            error!('Unauthorized.', 401)

          end
          { message: "pong" }
        end

      end
    end
  end