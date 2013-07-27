//
//  GlobalData.h
//  PlantTower0.1
//
//  Created by nomis on 5/14/13.
//  Copyright (c) 2013 nomis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GlobalData : NSObject
@property int winScale;
@property CGSize winSize;

@property int selectHero;
@property int selectMap;

@property (retain , nonatomic) CCArray *allHeros;
@property (retain , nonatomic) CCArray *allTowers;
@property (retain , nonatomic) CCArray *allCreeps;
@property (retain , nonatomic) CCArray *allMapItems;
@property (retain , nonatomic) NSMutableDictionary *gameConfig;

+ (GlobalData *)sharedInstance;
-(id)init;



//游戏接口
-(CGPoint) ccp : (int)x :(int)y;
-(CGPoint) ccpCenter;
-(CGPoint) ccpConvertToGL :(int)x : (int)y;
-(CGSize) spriteSize : (CCSprite*)sprite;
-(int) fontSize : (int)size;


-(int)getCrystalCount;
-(void)addCrystalCount:(int)index;
-(bool)lostCrystalCount:(int)index;
- (bool)nodeContainsPoint:(CCNode*)node point:(CGPoint)pt;
@end
