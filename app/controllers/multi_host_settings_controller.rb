class MultiHostSettingsController < ApplicationController

  before_filter :require_admin

  def index
    @multi_hosts = MultiHost.all
  end

  def edit
    @multi_host = MultiHost.find(params[:id])
  end



end