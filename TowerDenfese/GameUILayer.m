//
//  GameUILayer.m
//  TowerDenfese
//
//  Created by NOMIS on 6/28/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import "GameUILayer.h"
#import "GameScene.h"
#import "GameControllLayer.h"
#import "GameDefine.h"
#import "MoneySprite.h"
#import "WaveSprite.h"


@implementation GameUILayer

@synthesize pauseAndResumeItem;
@synthesize gameSpeedItem;
@synthesize globalData;
@synthesize gameData;
- (id)init
{
    self = [super init];
    if (self) {
        globalData = [GlobalData sharedInstance];
        gameData = [GameData sharedInstance];
        CGSize size = [globalData winSize];
        
        //右上角按扭
        CCMenuItem *pauseBtn1 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"UI_puaseBtn.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"UI_puaseBtn.png"] target:self selector:nil];
        CCMenuItem *pauseBtn2 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"UI_puaseBtn.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"UI_puaseBtn.png"] target:self selector:nil];
        
        CCMenuItem *speed1x = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"UI_1xSpeed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"UI_1xSpeed.png"] target:self selector:nil];
        CCMenuItem *speed2x = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"UI_2xSpeed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"UI_2xSpeed.png"] target:self selector:nil];
        
        CCMenuItem *controllItem = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"UI_ControllBtn.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"UI_ControllBtn.png"] target:self selector:@selector(controllAlert)];
        
        
        gameSpeedItem = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeSpeed) items:speed1x , speed2x, nil];
        pauseAndResumeItem = [CCMenuItemToggle itemWithTarget:self selector:@selector(pauseAndResume) items:pauseBtn1 , pauseBtn2, nil];
        CCMenu *speedChangeBtn = [CCMenu menuWithItems:gameSpeedItem, nil];
        CCMenu *pauseAndResumeBtn = [CCMenu menuWithItems:pauseAndResumeItem, nil];
        CCMenu *controllMenu = [CCMenu menuWithItems:controllItem, nil];
        
        speedChangeBtn.position = [globalData ccp:size.width-70  :size.height -20];
        pauseAndResumeBtn.position = [globalData ccp:size.width-30 :size.height -20];
        controllMenu.position = [globalData ccp:size.width-100 : size.height-20 ];
        
        [self addChild:speedChangeBtn];
        [self addChild:pauseAndResumeBtn];
        [self addChild:controllMenu];
        
        
        //左上角数值
        MoneySprite *moneySprite = [[[MoneySprite alloc]initWithSpriteFrameName:@"UI_moneyBoard.png" : gameData.money]autorelease];
        moneySprite.position = [globalData ccpConvertToGL:[globalData spriteSize:moneySprite].width/2+10 :20];
        [self addChild:moneySprite z:0 tag:GAME_TAG_SPRITE_MONEY];
        
        WaveSprite *waveSprite = [[WaveSprite alloc]initWithSpriteFrameName:@"UI_creepWaveBoard.png" :gameData.waveCount];
        waveSprite.position = [globalData ccpConvertToGL:[globalData spriteSize:moneySprite].width+20+[globalData spriteSize:waveSprite].width/2 :20];
        [self addChild:waveSprite z:0 tag:GAME_TAG_SPRITE_WAVE];
        
        
        //左下角英雄和技能
        
    }
    return self;
}



-(void)changeSpeed{
    if([gameSpeedItem selectedIndex] == 0){
        [[[CCDirector sharedDirector]scheduler]setTimeScale:1];
    }
    else{
        [[[CCDirector sharedDirector]scheduler]setTimeScale:2];
    }
}
-(void)pauseAndResume{
    if([pauseAndResumeItem selectedIndex] == 0){
        [[CCDirector sharedDirector]pause];
    }
    else{
        [[CCDirector sharedDirector]resume];
    }
}
-(void)controllAlert{
    
    [self unscheduleAllSelectors];
    GameControllLayer *controllLayer = [GameControllLayer node];
    if(![[[CCDirector sharedDirector]runningScene]getChildByTag:GAME_TAG_LAYER_CONTROLLMENU ])
        [[[CCDirector sharedDirector]runningScene] addChild:controllLayer z:GAME_LAYER_ALERT tag:GAME_TAG_LAYER_CONTROLLMENU];
    [[CCDirector sharedDirector]pause];
}

@end
