class ApplicationController < ActionController::API
# before_action :configure_permitted_parameters, if: :devise_controller?

#   protected

#   def configure_permitted_parameters
#     if resource_class == User
        
#         puts resource
#     end
#     devise_parameter_sanitizer.permit(:sign_in) do |u|
#         puts '--------------------'
#         u.permit(:name, :email, :password)
#     end
#   end
end
