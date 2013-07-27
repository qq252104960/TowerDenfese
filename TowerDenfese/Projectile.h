//
//  Projectile.h
//  TowerDenfese
//
//  Created by NOMIS on 6/24/13.
//  Copyright (c) 2013 nomis. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"
#import "GlobalData.h"
#import "GameData.h"
#import "Creep.h"
@interface Projectile : CCNode

@property (retain , nonatomic) GlobalData *globalData;
@property (retain , nonatomic) GameData *gameData;
@property (retain , nonatomic) NSString *towerName;
@property int normalFrameCount;
@property int effectFrameCount;
@property int projectileSpeed;
@property (retain , nonatomic) CCSprite *normalSprite;
@property (retain , nonatomic) Creep *targetCreep;
@property int towerIndex;

- (id)initWithTowerIndex:(int)index : (int)targetId;
- (void)action:(ccTime)delta;

@end
