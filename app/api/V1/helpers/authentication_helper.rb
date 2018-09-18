module V1
    module Helpers
        module AuthenticationHelpers
            extend Grape::API::Helpers
            def current_user
                # find token. Check if valid.
                binding.pry
                token = ApiKey.where(access_token: params[:token]).first
                if token && !token.expired?
                    @current_user = User.find(token.user_id)
                else
                    false
                end
            end

            def authenticate!
                binding.pry
                error!('Unauthorized. Invalid or expired token.', 401) unless current_user
            end
            

        end
    end
end