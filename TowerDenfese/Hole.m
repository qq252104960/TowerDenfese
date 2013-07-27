//
//  Hole.m
//  TowerDenfese
//
//  Created by NOMIS on 6/30/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import "Hole.h"


@implementation Hole
@synthesize type;
@synthesize tower;
@synthesize sprite;
@synthesize towerIndex;
@synthesize isBuilt;
-(id)initWithType : (int)Type{
    self = [super init];
    if(self){
        type = Type; 
        towerIndex = -1;
        tower = nil;
        if(type == 0)
            sprite = [[CCSprite alloc]initWithSpriteFrameName:@"hole1.png"];
        else
            sprite = [[CCSprite alloc]initWithSpriteFrameName:@"hole2.png"];
        [self addChild:sprite];
        self.contentSize = sprite.contentSize;
        isBuilt = NO;
    }
    return self;
}
@end
