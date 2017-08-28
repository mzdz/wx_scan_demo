class WeixinsController < ApplicationController

  before_action :gen_wx_jssdk_config, only: [:scan]

  def show
    signature = params[:signature]
    timestamp = params[:timestamp]
    nonce = params[:nonce]
    token = Settings.app.wechat.token
    calced_sign = Digest::SHA1.hexdigest([token, timestamp, nonce].sort.join)
    if signature == calced_sign
      render plain: params[:echostr]
    else
      render plain: "Forbidden", status: 403
    end
  end
end
