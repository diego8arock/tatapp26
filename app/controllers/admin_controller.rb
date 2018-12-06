class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  def index
  end
end
