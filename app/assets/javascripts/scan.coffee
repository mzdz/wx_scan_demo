$(document).on "turbolinks:load", () ->
  wx.config
    appId: jssdk_config.appId
    timestamp: jssdk_config.timestamp
    nonceStr: jssdk_config.nonceStr
    signature: jssdk_config.signature
    jsApiList: ["onMenuShareAppMessage", "onMenuShareTimeline"]
  wx.ready () ->
#    wx.scanQRCode
#      needResult: 1
#      scanType: ["qrCode"]
#      success: (res) ->
#        result = res.resultStr
#        alert(result)
    wx.onMenuShareTimeline
      title: '这是分享到朋友圈的标题'
      link: 'https://wx.kuaiyunma.com'
      imgUrl: 'https://wx2.kuaiyunma.com/img/share.jpg'
      success: ->
        alert("你分享成功了:)")
      cancel: ->
        alert("你故意分享失败了;)")
    wx.onMenuShareAppMessage
      title: '这是分享给朋友的标题'
      desc: '分享给朋友，说点啥呢？'
      link: 'https://wx.kuaiyunma.com'
      imgUrl: 'https://wx2.kuaiyunma.com/img/share.jpg'
      type: 'link'
      success: ->
        alert("你分享成功了:)")
      cancel: ->
        alert("你故意分享失败了;)")

  wx.error (res) ->
    alert("出错了, 请稍后重试")
