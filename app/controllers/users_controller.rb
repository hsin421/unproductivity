class UsersController < ApplicationController
 before_action :authenticate_user!, :except => [:homepage, :index, :welcome]


  def homepage
  end

  def index
  end

  def new
  end

  def pref
  	if params[:huffP] == "1" && current_user.content_providers.where('id'=> 1) == []
  		current_user.content_providers << ContentProvider.find(1)
  	elsif params[:huffP] != "1"
  		current_user.content_providers.delete(ContentProvider.find(1))
  	end
  	if params[:mash] == "1" && current_user.content_providers.where('id'=> 2) == []
  		current_user.content_providers << ContentProvider.find(2)
  	elsif params[:mash] != "1"
  		current_user.content_providers.delete(ContentProvider.find(2))
  	end
  	if params[:bloomberg] == "1" && current_user.content_providers.where('id'=> 3) == []
  		current_user.content_providers << ContentProvider.find(3)
  	elsif params[:bloomberg] != "1"
  		current_user.content_providers.delete(ContentProvider.find(3))
  	end
  	if params[:wired] == "1" && current_user.content_providers.where('id'=> 4) == []
  		current_user.content_providers << ContentProvider.find(4)
  	elsif params[:wired] != "1"
  		current_user.content_providers.delete(ContentProvider.find(4))
  	end
  	if params[:nyt] == "1" && current_user.content_providers.where('id'=> 5) == []
  		current_user.content_providers << ContentProvider.find(5)
  	elsif params[:nyt] != "1"
  		current_user.content_providers.delete(ContentProvider.find(5))
  	end			
 	if params[:npr] == "1" && current_user.content_providers.where('id'=> 6) == []
  		current_user.content_providers << ContentProvider.find(6)
  	elsif params[:npr] != "1"
  		current_user.content_providers.delete(ContentProvider.find(6))
  	end
  	if params[:jcrew] == "1" && current_user.content_providers.where('id'=> 7) == []
  		current_user.content_providers << ContentProvider.find(7)
  	elsif params[:jcrew] != "1"
  		current_user.content_providers.delete(ContentProvider.find(7))
  	end
  
  @user = current_user

  puts "******#{@user.content_providers.all}************"

  redirect_to root_path
  end

  def update
  end

end
