//
//  GameScene.h
//  TowerDenfese
//
//  Created by NOMIS on 6/18/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameData.h"
#import "GlobalData.h"

@interface GameScene : CCLayer {
    
}
@property (retain , nonatomic) GlobalData *globalData;
@property (retain , nonatomic) GameData *gameData;
+(CCScene *) scene;

@end
