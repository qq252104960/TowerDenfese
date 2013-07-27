//
//  GameWinLayer.h
//  TowerDenfese
//
//  Created by NOMIS on 6/28/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GlobalData.h"
#import "LoadingScene.h"
#import "GameDefine.h"
#import <BaiduSocialShare/BDSocialShareSDK.h>
@interface GameWinLayer : CCLayer {
    
}

@property (retain , nonatomic) GlobalData *globalData;
@property (retain, nonatomic) CCMenu* sharedMenu;
@property (retain , nonatomic) CCMenu* continueMenu;
@property (retain , nonatomic) CCMenu* restartMenu;

@end
