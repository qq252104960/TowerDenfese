//
//  MapItem.h
//  TowerDenfese
//
//  Created by NOMIS on 6/24/13.
//  Copyright (c) 2013 nomis. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"
#import "GameData.h"
#import "GlobalData.h"
@interface MapItem : CCNode

@property (retain , nonatomic) GameData *gameData;
@property (retain , nonatomic) GlobalData *globalData;
@property int itemId;
@property (retain , nonatomic) NSString *itemName;
@property int frameCount;

@property (retain , nonatomic) CCSprite *normalSprite;
- (id)initWithItemId:(int)index withX:(int)px withY:(int)py;

@end
