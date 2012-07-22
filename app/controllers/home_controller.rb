class HomeController < ApplicationController
  skip_before_filter :authorize
  layout 'home'
  def index
  end
end
