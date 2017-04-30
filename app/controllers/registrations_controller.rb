class RegistrationsController < Devise::RegistrationsController

before_action :city_location
def city_location
	@location_city = request.location.city
end

 private

 def sign_up_params
   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar, :avatar_cache, :remove_avatar, :location)
 end

 def account_update_params
   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar, :location)
 end
end