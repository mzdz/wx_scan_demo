class WelcomeController < ApplicationController

  before_action :gen_wx_jssdk_config

  def index
  end
end
