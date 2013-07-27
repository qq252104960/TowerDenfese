//
//  BDSocialShareTheme.h
//  Baidu Social Share SDK
//
//  Created by Baidu Developer Center on 13-5-8.
//  官网地址:http:developer.baidu.com
//  技术支持邮箱:xiawenhai@baidu.com
//  Copyright (c) 2013年 baidu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * BDSocialShareTheme是分享UI的主题类，可以通过它生成属于自己应用风格的主题。
 */

@interface BDSocialShareTheme : NSObject

/** @name 构造主题 */
/**
 *	@brief	生成一个主题对象
 */
+(BDSocialShareTheme *)newTheme;

/** @name Header */
/**
 *	@brief	设置Header的主题风格
 *
 *	@param 	backgroundImage     header的背景图片
 *	@param 	headerTitleColor    header上标题的文本颜色
 *	@param 	buttonImage         header上Button的背景图片
 *  @param 	buttonTitleColor    header上Button的字体颜色
 */
-(void)setHeaderThemeWithBackgroundImage:(UIImage *)backgroundImage
                        headerTitleColor:(UIColor *)headerTitleColor
                             buttonImage:(UIImage *)buttonImage
                        buttonTitleColor:(UIColor *)buttonTitleColor;

/** @name 分享菜单 */
/**
 *	@brief	设置分享菜单页面的主题
 *
 *	@param 	icon                分享菜单header的icon
 *	@param 	backgroundColor     分享菜单的背景颜色
 *	@param 	characterColor      分享菜单的文字颜色
 *  @param 	footerImage         分享菜单底部的背景图片
 *	@param 	buttonImage         分享菜单中 “取消” button的图片
 *  @param 	buttonTitleColor    分享菜单中 “取消” button的字体颜色
 */
-(void)setShareMenuViewThemeOfThemeStyleWithHeaderIcon:(UIImage *)icon
                                       backgroundColor:(UIColor *)backgroundColor
                                        characterColor:(UIColor *)characterColor
                                           footerImage:(UIImage *)footerImage
                                     cancelButtonImage:(UIImage *)buttonImage
                                cancelButtonTitleColor:(UIColor *)buttonTitleColor;

/** @name 授权页面 */
/**
 *	@brief	设置授权页面的主题
 *
 *	@param 	goBackImage          授权页面返回button的图片
 */
-(void)setAuthorizeViewThemeWithGoBackImage:(UIImage *)goBackImage;

/** @name 分享内容编辑页面 */
/**
 *	@brief	设置分享内容编辑页面的主题
 *
 *	@param 	backgroundColor             页面的背景颜色
 *	@param 	textViewBackgroundColor     文字编辑框的背景颜色
  *	@param 	characterColor              编辑的文字内容及剩余字数显示的字体颜色
 */
-(void)setEidtViewThemeWithBackgroundColor:(UIColor *)backgroundColor
                   textViewBackgroundColor:(UIColor *)textViewBackgroundColor
                            characterColor:(UIColor *)characterColor;

@end
