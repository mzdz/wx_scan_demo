require 'digest/sha1'
require "uri"
require "securerandom"
require './lib/wx_sign.rb'

class ApplicationController < ActionController::Base
  include WxSign

  protect_from_forgery with: :exception

  private

  def gen_wx_jssdk_config
    timestamp = DateTime.now.to_i
    random = SecureRandom.hex
    sign = gen_sign(random, timestamp, request.original_url.gsub("http://", "https://"))
    @jssdk_config = { appId: Settings.app.wechat.appid, timestamp: timestamp, nonceStr: random, signature: sign }
  end

end
