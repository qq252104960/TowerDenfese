//
//  Created by Baidu Developer Center on 13-3-10.
//  官网地址:http:developer.baidu.com
//  技术支持邮箱:xiawenhai@baidu.com
//  Copyright (c) 2013年 baidu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * BDSocialShareContent是分享的内容类，包括描述、url地址，分享内容的标题，分享附带的图片资源。
 * BDSocialShareContent提供了方便的接口来生成一个内容类的对象，可以同时设置好描述，url地址，分享内容的标题等信息。BDSocialShareContent还提供了一个添加图片资源的接口。
 */

@interface BDSocialShareContent : NSObject

/** @name 属性 */
/**
 *	@brief	生成分享内容对象分享的文字内容，可以是用户的评论或者对分享内容的描述
 */
@property(nonatomic,retain)NSString *description;

/**
 *	@brief	分享的URL
 */
@property(nonatomic,retain)NSString *url;

/**
 *	@brief	分享内容的标题
 */
@property(nonatomic,retain)NSString *title;

/** @name 构造分享内容对象&设置分享内容 */
/**
 *	@brief	生成分享内容对象
 *	@param 	description         分享的描述
 *	@param 	url                 分享的URL
 *	@param 	title               分享的标题
 */
+(BDSocialShareContent *)shareContentWithDescription:(NSString *)description
                                                 url:(NSString *)url
                                               title:(NSString *)title;

/**
 *  @brief	添加图片资源
 *	@param 	imageSource         缩略图/上传的图片
 *	@param 	imageUrl            图片的url地址
 * 
 *  @discussion 如果两个参数同时为nil，分享内容视为没有图片资源;如果两个参数都有值，分享是优先使用imageUrl进行分享。
 * 
 *  直接使用UI接口完成分享功能时，建议imageUrl和imageSource同时提供(imageSource作为缩略图,image作为分享的图片地址)，否则组件会通过网络加载图片，可能会造成用户网络流量的损耗。
 */
-(void)addImageWithImageSource:(UIImage *)imageSource imageUrl:(NSString *)imageUrl;
@end
