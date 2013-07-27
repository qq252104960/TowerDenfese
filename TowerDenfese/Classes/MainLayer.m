//
//  MainLayer.m
//  PlantTower0.1
//
//  Created by nomis on 5/14/13.
//  Copyright (c) 2013 nomis. All rights reserved.
//

#import "MainLayer.h"
#import "GameDefine.h"
#import "GameScene.h"
#import "GlobalData.h"
#import "LoadingScene.h"
@implementation MainLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    MainLayer *layer = [MainLayer node];
	[scene addChild: layer];
	return scene;
}
- (id)init
{
    self = [super init];
    if (self) {
        GlobalData *globalData = [GlobalData sharedInstance];

                
        [CCMenuItemFont setFontSize:30];
        CCMenuItem *item1 = [CCMenuItemFont itemWithString:@"GAME START" target:self selector:@selector(GameStart)];


        CCMenu *menu = [CCMenu menuWithItems:item1, nil];
        [self addChild:menu];
        
        globalData.selectMap = 1;

    }
    return self;
}
-(void)GameStart{

    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:GAME_SCENE_SELECTCHAPTER]];
    
}
@end
