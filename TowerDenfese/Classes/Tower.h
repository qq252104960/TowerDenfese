//
//  Tower.h
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

@interface Tower : CCSprite
@property (retain , nonatomic) GlobalData *globalData;
@property (retain , nonatomic) GameData *gameData;
@property int towerId;
@property (nonatomic , retain) NSString *towerName;
@property (nonatomic , retain) NSString *spriteName;
@property int attackDamage;
@property float attackSpeed;
@property int attackRange;
@property bool isAttacking;
@property float attackDelay;
@property (retain , nonatomic) Creep *targetCreep;

@property (retain , nonatomic) CCSprite* normalFrame;
@property (retain , nonatomic) CCArray *nextLevels;
-(id) initWithTowerIndex :(int) index;
-(void)draw;

@end
