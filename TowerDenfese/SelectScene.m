//
//  SelectScene.m
//  TowerDenfese
//
//  Created by nomis on 7/19/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import "SelectScene.h"
#import "LoadingScene.h"
#import "GlobalData.h"
#import "GameDefine.h"
@implementation SelectScene
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    SelectScene *layer = [SelectScene node];
	[scene addChild: layer];
	return scene;
}
- (id)init
{
    self = [super init];
    if (self) {
        GlobalData *globalData = [GlobalData sharedInstance];
        
        CCMenuItem *item1 = [CCMenuItemFont itemWithString:@"map1" block:^(id sender) {
            globalData.selectMap = 1;
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:GAME_SCENE_PLAY]];
        }];
        CCMenuItem *item2 = [CCMenuItemFont itemWithString:@"map2" block:^(id sender) {
            globalData.selectMap = 2;
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:GAME_SCENE_PLAY]];
        }];
        CCMenuItem *item3 = [CCMenuItemFont itemWithString:@"map3" block:^(id sender) {
            globalData.selectMap = 3;
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:GAME_SCENE_PLAY]];
        }];
        CCMenuItem *item4 = [CCMenuItemFont itemWithString:@"map4" block:^(id sender) {
            globalData.selectMap = 4;
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:GAME_SCENE_PLAY]];
        }];
        
        CCMenu *menu = [CCMenu menuWithItems:item1,item2 , item3 , item4, nil];
        [menu alignItemsHorizontallyWithPadding:10];
        menu.position = [globalData ccpCenter];
        [self addChild:menu];

    }
    return self;
}
@end
