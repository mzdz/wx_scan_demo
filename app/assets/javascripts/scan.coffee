$(document).on "turbolinks:load", () ->
  wx.config
    appId: jssdk_config.appId,
    timestamp: jssdk_config.timestamp,
    nonceStr: jssdk_config.nonceStr,
    signature: jssdk_config.signature,
    jsApiList: ["scanQRCode"]

  wx.ready () ->
    wx.scanQRCode
      needResult: 1,
      scanType: ["qrCode"],
      success: (res) ->
        result = res.resultStr
        reg = /^[a-zA-Z0-9\/+]*={0,2}$/
        if reg.test(result)
          alert(result)

  wx.error (res) ->
    alert("出错了, 请稍后重试")
