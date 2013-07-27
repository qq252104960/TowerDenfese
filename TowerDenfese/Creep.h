//
//  Creep.h
//  TowerDenfese
//
//  Created by NOMIS on 6/28/13.
//  Copyright 2013 nomis. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d.h"
#import "GlobalData.h"
#import "GameData.h"
#import "WayPoint.h"
@interface Creep : CCNode {
    
}

@property (retain , nonatomic) GlobalData *globalData;
@property (retain , nonatomic) GameData *gameData;

@property int creepId;
@property (retain , nonatomic) NSString* creepName;
@property (retain , nonatomic) NSString* spriteName;
@property int speed;
@property int hpNow;
@property int hpMax;
@property int physicalDenfense;
@property int magicDenfense;
@property int loseOfLife;
@property int pathNo;
@property bool isDead;
@property (retain , nonatomic) WayPoint* nowPosition;
@property (retain , nonatomic) WayPoint* nextPosition;

@property (retain , nonatomic) CCSprite* normalFrame;

@property int nowWayPointIndex;

@property (retain , nonatomic) CCProgressTimer* bloodProgress;
-(id) initWithCreepIndex :(int) index withPathNo : (int)PathNo;

-(void) setState : (int)index;

-(void) loseLife : (int)index;
-(void) addLife : (int)index;

-(void) decreaseSpeed : (int)index;
-(void) increaseSpeed : (int)index;

-(void) decreasePhysicalDenfense : (int)index;
-(void) increasePhysicalDenfense : (int)index;

-(void) decreaseMagicDenfense : (int)index;
-(void) increaseMagicDenfense : (int)index;

@end
