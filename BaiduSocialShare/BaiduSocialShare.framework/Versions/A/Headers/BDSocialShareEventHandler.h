//
//  Created by Baidu Developer Center on 13-3-10.
//  官网地址:http:developer.baidu.com
//  技术支持邮箱:xiawenhai@baidu.com
//  Copyright (c) 2013年 baidu.com. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "BDSocialShareMacroDef.h"
/**
 *	@brief	请求回调事件处理
 *
 *  @param  requestResult   回调结果状态
 *  @param  shareType       分享平台类型
 *  @param  response        API请求返回的数据
 *  @param  error           请求失败的错误信息
 */
typedef void(^BDSocialShareEventHandler) (SHARE_RESULT requestResult,NSString *shareType,id response,NSError *error);

