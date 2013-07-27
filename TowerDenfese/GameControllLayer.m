//
//  GameControllLayer.m
//  TowerDenfese
//
//  Created by NOMIS on 6/28/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import "GameControllLayer.h"
#import "LoadingScene.h"
#import "GameDefine.h"

@implementation GameControllLayer

@synthesize globalData;
- (id)init
{
    self = [super init];
    if (self) {
        globalData = [GlobalData sharedInstance];
        CCMenuItem *replayGame =  [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"sharedImg1.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"sharedImg1.png"] block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:GAME_SCENE_PLAY]];
            [[CCDirector sharedDirector]resume];
        }];
        CCMenuItem *continueGame = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"sharedImg2.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"sharedImg2.png"] block:^(id sender) {
            [[[CCDirector sharedDirector] runningScene] removeChildByTag:GAME_TAG_LAYER_CONTROLLMENU];
            [[CCDirector sharedDirector] resume];
        }];
        CCMenuItem *backToSelectGame = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"sharedImg3.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"sharedImg3.png"] block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:GAME_SCENE_SELECTCHAPTER]];
            [[CCDirector sharedDirector] resume];
        }];
        
        CCMenu *menu = [CCMenu menuWithItems:replayGame , continueGame , backToSelectGame, nil];
        [menu alignItemsVerticallyWithPadding:20];
        menu.position = [globalData ccpCenter];
        [self addChild:menu];
    }
    return self;
}
@end
