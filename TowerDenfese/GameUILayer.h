//
//  GameUILayer.h
//  TowerDenfese
//
//  Created by NOMIS on 6/28/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "GlobalData.h"
#import "GameData.h"

@interface GameUILayer : CCLayer {
    
}
@property (retain , nonatomic) GameData *gameData;
@property (retain , nonatomic) CCMenuItemToggle *gameSpeedItem;
@property (retain , nonatomic) CCMenuItemToggle *pauseAndResumeItem;
@property (retain  ,nonatomic) GlobalData* globalData;

@end
