//
//  Created by Baidu Developer Center on 13-3-10.
//  官网地址:http:developer.baidu.com
//  技术支持邮箱:xiawenhai@baidu.com
//  Copyright (c) 2013年 baidu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	@brief	回调结果状态
 */
typedef enum {
    BD_SOCIAL_SHARE_SUCCESS = 0,        //成功
    BD_SOCIAL_SHARE_FAIL,               //失败
    BD_SOCIAL_SHARE_CANCEL,             //取消
} SHARE_RESULT;

/**
 *	@brief	分享菜单的样式
 */
typedef enum {
    BD_SOCIAL_SHARE_MENU_THEME_STYLE = 0,         //主题风格
    BD_SOCIAL_SHARE_MENU_BOX_STYLE,               //iOS系统原生风格
    BD_SOCIAL_SHARE_MENU_SIMPLE_STYLE,            //简洁风格
} SHARE_MENU_STYLE;

/**
 *	@brief	分享类型
 */
//新浪微博
#define kBD_SOCIAL_SHARE_PLATFORM_SINAWEIBO         @"sinaweibo"
//QQ空间
#define kBD_SOCIAL_SHARE_PLATFORM_QQZONE            @"qqdenglu"
//开心网
#define kBD_SOCIAL_SHARE_PLATFORM_KAIXIN            @"kaixin"
//QQ微博
#define kBD_SOCIAL_SHARE_PLATFORM_QQWEIBO           @"qqweibo"
//微信
#define kBD_SOCIAL_SHARE_PLATFORM_WEIXIN_SESSION    @"weixin_session"
//朋友圈
#define kBD_SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE   @"weixin_timeline"
//邮件
#define kBD_SOCIAL_SHARE_PLATFORM_EMAIL             @"email"
//短信
#define kBD_SOCIAL_SHARE_PLATFORM_SMS               @"sms"

/**
 *	@brief	授权错误码定义
 */
//未知错误
#define BD_SOCIAL_SHARE_AUTHORIZE_ERRORCODE_UNKNOWN                     1
//服务暂时不可用
#define BD_SOCIAL_SHARE_AUTHORIZE_ERRORCODE_SERVICE_UNAVAILABLE         2
//调用次数过于频繁
#define BD_SOCIAL_SHARE_AUTHORIZE_ERRORCODE_REQUEST_FREQUENTLY          3
//第三方开放平台出错
#define BD_SOCIAL_SHARE_AUTHORIZE_ERRORCODE_THIRD_PLATFORM              4
//参数缺失错误
#define BD_SOCIAL_SHARE_AUTHORIZE_ERRORCODE_MISSING_PARAM              100
//登录会话已经过期
#define BD_SOCIAL_SHARE_AUTHORIZE_ERRORCODE_SESSION_EXPIRE_IN          111

/**
 *	@brief	API错误码定义
 */
//未知错误
#define BD_SOCIAL_SHARE_API_ERRORCODE_UNKNOWN                     1
//服务暂时不可用
#define BD_SOCIAL_SHARE_API_ERRORCODE_SERVICE_UNAVAILABLE         2
//第三方开放平台服务不可用
#define BD_SOCIAL_SHARE_API_ERRORCODE_THIRD_PLATFORM              3
//接口调用次数已经达到上限
#define BD_SOCIAL_SHARE_API_ERRORCODE_LIMIT_REACHED               4
//请求来自未认证的IP
#define BD_SOCIAL_SHARE_API_ERRORCODE_UNAUTHORIZED_IP             5
//无权限访问该用户数据
#define BD_SOCIAL_SHARE_API_ERRORCODE_NO_PERMISSION               6
//请求参数无效
#define BD_SOCIAL_SHARE_API_ERRORCODE_INVALID_PARAM              100
//API KEY无效
#define BD_SOCIAL_SHARE_API_ERRORCODE_INVALID_APIKEY             101
//请求参数过多
#define BD_SOCIAL_SHARE_API_ERRORCODE_PARAM_TOOLONG              102
//无效Token
#define BD_SOCIAL_SHARE_API_ERRORCODE_INVALID_TOKEN              110
//Token过期
#define BD_SOCIAL_SHARE_API_ERRORCODE_EXPIRED_TOKEN              111

/**
 *	@brief	组件错误码定义
 */
//sdk未被初始化
#define BD_SOCIAL_SHARE_LOCAL_ERRORCODE_UNINITIALIZED            1000
//无网络错误
#define BD_SOCIAL_SHARE_LOCAL_ERRORCODE_NONETWORK                1001
//无效Token错误
#define BD_SOCIAL_SHARE_LOCAL_ERRORCODE_INVALID_TOKEN            1002
//无效的平台标示
#define BD_SOCIAL_SHARE_LOCAL_ERRORCODE_INVALID_SHARETYPE        1003
//无效的分享内容
#define BD_SOCIAL_SHARE_LOCAL_ERRORCODE_INVALID_SHARECONTENT     1004
//未安装微信
#define BD_SOCIAL_SHARE_LOCAL_ERRORCODE_WEIXIN_NOTINSTALL         1005
//微信应用ID无效
#define BD_SOCIAL_SHARE_LOCAL_ERRORCODE_INVALID_WEIXIN_APPID      1006
//其他微信错误
#define BD_SOCIAL_SHARE_LOCAL_ERRORCODE_WEIXIN_ERROR              1007
//发送短信错误
#define BD_SOCIAL_SHARE_LOCAL_ERRORCODE_SEND_MESSAGE_FAIL         1008
//发送邮件错误
#define BD_SOCIAL_SHARE_LOCAL_ERRORCODE_SEND_EMAIL_FAIL           1009

