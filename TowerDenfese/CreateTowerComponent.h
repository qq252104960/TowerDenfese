//
//  CreateTowerComponent.h
//  TowerDenfese
//
//  Created by NOMIS on 7/1/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GlobalData.h"
#import "Hole.h"
#import "GameData.h"
@interface CreateTowerComponent : CCLayer {
    
}
@property (retain , nonatomic) GlobalData *globalData;
@property (retain , nonatomic) GameData *gameData;
@property (retain , nonatomic) Hole *hole;
@property (retain , nonatomic) CCArray *items;
- (id)initWithHoleIndex : (Hole*)index;
@end
