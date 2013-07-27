//
//  GameData.h
//  TowerDenfese
//
//  Created by NOMIS on 6/23/13.
//  Copyright (c) 2013 nomis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameData : NSObject
@property (retain , nonatomic) CCNode *baseLayer;
@property (nonatomic , retain) CCArray* mapItems;
@property (nonatomic , retain) CCArray* projectiles;
@property (nonatomic , retain) CCArray* creeps;
@property (nonatomic , retain) CCArray* towers;
@property (nonatomic , retain) CCArray* wayPoints;
@property (nonatomic , retain) CCArray* waves;
@property (nonatomic , retain) CCArray* holes;

@property CGPoint initPoint;
@property CGPoint targetPoint;


@property int life;
@property int fullLife;
@property int waveCount;
@property int money;
@property int wave;
@property int nowCreepInWaveIndex;
@property bool isTowerCreateComponentSelect;
+ (GameData *)sharedInstance;
+ (void)releaseInstance;

- (void)loseLife:(int)index;
- (void)addMoney:(int)index;
- (bool)loseMoney:(int)index;
- (bool)isMoneyEnough : (int)index;
- (void)addWave;
@end
