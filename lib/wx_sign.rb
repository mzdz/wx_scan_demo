module WxSign

  #基础支持token
  def weixin_base_token_url(app_id, app_secret)
    "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{app_id}&secret=#{app_secret}"
  end

  def js_api_ticket_url(access_token)
    "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=#{access_token}&type=jsapi"
  end

  def gen_sign(noncestr = nil, timestamp = nil, url = nil)
    str = { noncestr: noncestr, timestamp: timestamp, url: url, jsapi_ticket: get_jsapi_ticket }.sort.map {|x, y| "#{x.downcase}=#{y}" }.join("&")
    Digest::SHA1.hexdigest str
  end

  def get_jsapi_ticket
    if session["jsapi_ticket"].blank? || (session["jsapi_ticket_expired_at"] && DateTime.now >= session["jsapi_ticket_expired_at"].to_datetime)
      token = get_base_access_token
      resp = RestClient.get(js_api_ticket_url(token))
      json = JSON.parse(resp)
      render json: { code: -1, message: json["errmsg"], data: {} } if json["errcode"].to_i != 0
      ticket = json["ticket"]
      session["jsapi_ticket"] = ticket
      session["jsapi_ticket_expired_at"] = DateTime.now + 7000.seconds
    end
    session["jsapi_ticket"]
  end

  def get_base_access_token
    if session["base_access_token"].blank? || (session["base_access_token_expired_at"] && DateTime.now >= session["base_access_token_expired_at"].to_datetime)
      resp = RestClient.get(weixin_base_token_url(Settings.app.wechat.appid, Settings.app.wechat.appsecret))
      json = JSON.parse(resp)
      render json: { code: -1, message: json["errmsg"], data: {} } if json["errcode"].to_i != 0
      access_token = json["access_token"]
      session["base_access_token"] = access_token
      session["base_access_token_expired_at"] = DateTime.now + 7000.seconds
    end
    session["base_access_token"]
  end
end
