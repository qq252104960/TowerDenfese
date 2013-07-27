//
//  Hole.h
//  TowerDenfese
//
//  Created by NOMIS on 6/30/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tower.h"
@interface Hole : CCNode {
    
}

@property int type;
@property (retain , nonatomic) CCSprite *sprite;
@property (retain  ,nonatomic) Tower *tower;
@property int towerIndex;
@property bool isBuilt;
-(id)initWithType : (int)Type;

@end
