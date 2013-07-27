//
//  BDSocialShareSDK.h
//  Baidu Social Share SDK
//
//  Created by Baidu Developer Center on 13-3-10.
//  官网地址:http:developer.baidu.com
//  技术支持邮箱:xiawenhai@baidu.com
//  Copyright (c) 2013年 baidu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDSocialShareMacroDef.h"
#import "BDSocialShareEventHandler.h"
#import "BDSocialShareContent.h"
#import "BDSocialShareTheme.h"

/**
 * BDSocialShareSDK是百度社会化分享组件的主要功能类，提供了第三方平台授权信息管理、分享、获取用户信息等接口，分享平台包括新浪微博，腾讯微博，QQ空间，开心网，微信，短信和邮件等。
 * 另外，BDSocialShareSDK还提供了功能完整的UI接口，将选择分享平台，分享内容编辑和发送分享功能相关页面封装在一起，提供给开发者使用。为了使得分享UI与开发者的应用风格保持一直，可以通过BDSocialShareTheme中的UI定制接口，对这些页面进行样式的定制，实现非常简便。
 */

@interface BDSocialShareSDK : NSObject

/** @name 初始化&销毁 */
/**
 *	@brief	注册应用,此方法在应用启动时调用一次
 *  @discussion 支持的分享平台标识包括：
 *  kBD_SOCIAL_SHARE_PLATFORM_SINAWEIBO
 *  kBD_SOCIAL_SHARE_PLATFORM_QQZONE
 *  kBD_SOCIAL_SHARE_PLATFORM_KAIXIN
 *  kBD_SOCIAL_SHARE_PLATFORM_QQWEIBO
 *  kBD_SOCIAL_SHARE_PLATFORM_WEIXIN_SESSION
 *  kBD_SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE
 *  kBD_SOCIAL_SHARE_PLATFORM_EMAIL
 *  kBD_SOCIAL_SHARE_PLATFORM_SMS
 *  分享平台标识可以参看BDSocialShareMacroDef.h文件中的定义。
 *
 *	@param 	appKey      应用Key
 *	@param 	platforms   分享平台类型列表
 */
+ (void)registerApiKey:(NSString *)apiKey andSupportPlatforms:(NSArray *)platforms;

/**
 *	@brief	使用微信功能必须先注册微信的应用ID，此方法在应用启动时调用一次
 *
 *	@param 	appid      微信应用的id
 */
+ (void)registerWXApp:(NSString *)appId;

/**
 *	@brief	使用新浪微博客户端的SSO功能，需要调用此方法注册新浪微博的应用ID
 *
 *	@param 	appid      新浪微博应用的id
 */
+ (void)enableSinaWeiboSSOWithAppId:(NSString *)appId;

/**
 *	@brief	使用QQ客户端的SSO功能，需要调用此方法注册QQ的应用ID
 *
 *	@param 	appid      QQ应用的id
 */
+ (void)enableQQSSOWithAppId:(NSString *)appId;

/**
 *	@brief 释放分享组件使用的内存资源
 */
+(void)destroy;

/** @name 授权信息管理 */
/**
 *	@brief	返回授权信息是否有效
 *  @discussion 支持的分享平台标识包括：
 *  kBD_SOCIAL_SHARE_PLATFORM_SINAWEIBO
 *  kBD_SOCIAL_SHARE_PLATFORM_QQZONE
 *  kBD_SOCIAL_SHARE_PLATFORM_KAIXIN
 *  kBD_SOCIAL_SHARE_PLATFORM_QQWEIBO
 *  分享平台标识可以参看BDSocialShareMacroDef.h文件中的定义。
 *
 *	@param 	shareType   分享平台类型
 *  @return 如果AccessToken是有效的返回YES,否则返回NO.
 */
+ (BOOL)isAccessTokenValidWithShareType:(NSString *)shareType;

/**
 *	@brief	清除授权信息
 *
 *	@param 	shareType   分享平台类型
 */
+ (void)clearAuthorizeWithShareType:(NSString *)shareType;

/**
 *	@brief	显示授权页面
 *  @discussion 支持的分享平台标识包括：
 *  kBD_SOCIAL_SHARE_PLATFORM_SINAWEIBO
 *  kBD_SOCIAL_SHARE_PLATFORM_QQZONE
 *  kBD_SOCIAL_SHARE_PLATFORM_KAIXIN
 *  kBD_SOCIAL_SHARE_PLATFORM_QQWEIBO
 *  分享平台标识可以参看BDSocialShareMacroDef.h文件中的定义。
 *
 *	@param 	shareType   分享平台类型
 *	@param 	result      授权返回事件处理
 */
+ (void)authorizeWithShareType:(NSString *)shareType result:(BDSocialShareEventHandler)result;

/** @name 分享API接口 */
/**
 *	@brief	分享接口
 *  @discussion 支持的分享平台标识包括：
 *  kBD_SOCIAL_SHARE_PLATFORM_SINAWEIBO
 *  kBD_SOCIAL_SHARE_PLATFORM_QQZONE
 *  kBD_SOCIAL_SHARE_PLATFORM_KAIXIN
 *  kBD_SOCIAL_SHARE_PLATFORM_QQWEIBO
 *  kBD_SOCIAL_SHARE_PLATFORM_WEIXIN_SESSION
 *  kBD_SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE
 *  kBD_SOCIAL_SHARE_PLATFORM_EMAIL
 *  kBD_SOCIAL_SHARE_PLATFORM_SMS
 *  分享平台标识可以参看BDSocialShareMacroDef.h文件中的定义。
 *
 *	@param 	shareType   分享平台类型
 *	@param 	content     分享内容
 *	@param 	result      分享返回事件处理
 */
+ (void)shareWithShareType:(NSString *)shareType content:(BDSocialShareContent*)content result:(BDSocialShareEventHandler)result;

/**
 *	@brief	第三方平台批量分享接口
 *  @discussion 支持的分享平台标识包括：
 *  kBD_SOCIAL_SHARE_PLATFORM_SINAWEIBO
 *  kBD_SOCIAL_SHARE_PLATFORM_QQZONE
 *  kBD_SOCIAL_SHARE_PLATFORM_KAIXIN
 *  kBD_SOCIAL_SHARE_PLATFORM_QQWEIBO
 *  分享平台标识可以参看BDSocialShareMacroDef.h文件中的定义。
 *
 *	@param 	shareTypes  分享平台列表
 *	@param 	content     分享内容
 *	@param 	result      分享返回事件处理
 */
+ (void)shareToCommunitiesWithShareTypes:(NSArray *)shareTypes content:(BDSocialShareContent*)content result:(BDSocialShareEventHandler)result;

/** @name 获取用户信息API接口 */
/**
 *	@brief	取得用户信息
 *  @discussion 支持的分享平台标识包括：
 *  kBD_SOCIAL_SHARE_PLATFORM_SINAWEIBO
 *  kBD_SOCIAL_SHARE_PLATFORM_QQZONE
 *  kBD_SOCIAL_SHARE_PLATFORM_KAIXIN
 *  kBD_SOCIAL_SHARE_PLATFORM_QQWEIBO
 *  分享平台标识可以参看BDSocialShareMacroDef.h文件中的定义。
 *
 *	@param 	shareType   分享平台类型
 *	@param 	result      取得用户信息返回事件处理
 */
+ (void)getUserInfoWithShareType:(NSString *)shareType result:(BDSocialShareEventHandler)result;

/** @name 分享UI接口 */
/**
 *	@brief	设置分享界面的主题
 *
 *	@param 	theme     主题
 */
+ (void)setSocialShareTheme:(BDSocialShareTheme *)theme;

/**
 *	@brief	显示分享平台菜单
 *
 *	@param 	content     分享内容
 *	@param 	style       分享菜单样式
 *	@param 	result      取得用户信息返回事件处理
 */
+ (void)showShareMenuWithShareContent:(BDSocialShareContent *)content menuStyle:(SHARE_MENU_STYLE)style result:(BDSocialShareEventHandler)result;

/** @name 第三方客户端回调处理 */
/**
 *	@brief 处理微信通过URL启动App时传递的数据
 *
 *	@param 	url         启动App的URL
 */
+(BOOL)handleOpenURL:(NSURL *)url;


@end
