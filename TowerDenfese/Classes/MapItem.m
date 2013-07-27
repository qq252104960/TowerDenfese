//
//  MapItem.m
//  TowerDenfese
//
//  Created by NOMIS on 6/24/13.
//  Copyright (c) 2013 nomis. All rights reserved.
//

#import "MapItem.h"

@implementation MapItem

@synthesize itemId;
@synthesize globalData;
@synthesize itemName;
@synthesize frameCount;

@synthesize normalSprite;
@synthesize gameData;
-(void)dealloc{
    [normalSprite release] , normalSprite = nil;
    [super dealloc];
}
- (id)initWithItemId:(int)index withX:(int)px withY:(int)py
{
    self = [super init];
    if (self) {
        gameData = [GameData sharedInstance];
        globalData = [GlobalData sharedInstance];
 
        itemId = index;
        frameCount = [[[globalData.allMapItems objectAtIndex:index] valueForKey:@"FrameCount"]intValue];

        
        itemName = [[globalData.allMapItems objectAtIndex:index] valueForKey:@"ItemName"];
        
        NSString *fileName= [NSString stringWithFormat:@"%@/0000" , itemName];
        normalSprite = [CCSprite spriteWithSpriteFrameName:fileName];
        self.contentSize= normalSprite.contentSize;
        self.position = [globalData ccp:px :py ];
        [self addChild:normalSprite];
        id action = [CCCallFunc actionWithTarget:self selector:@selector(play)];
        [self runAction:action];

    }
    return self;
}
-(void)play{
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    NSMutableArray *frames = [NSMutableArray array];
    for(int i = 0; i<frameCount;i++){
        NSString *fileName;
        if(i<10)
            fileName= [NSString stringWithFormat:@"%@/000%d" , itemName , i];
        else{
            fileName = [NSString stringWithFormat:@"%@/00%d" , itemName , i ];
        }
        [frames addObject:[frameCache spriteFrameByName:fileName]];
    }
    
    CCAnimation* anim = [CCAnimation animationWithSpriteFrames:frames delay:0.042];
    CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
    CCAnimate* animate2 = [CCAnimate actionWithDuration:5.0f];
    id action = [CCSequence actions:
                 animate , animate2 , nil];
    CCRepeatForever* actBody = [CCRepeatForever actionWithAction:action];
    [normalSprite runAction:actBody];
}

@end
