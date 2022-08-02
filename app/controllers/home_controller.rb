class HomeController < ApplicationController
  before_action :redirect_if_signed_in
  
  def root
  end
end
