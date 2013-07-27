//
//  LoadingScene.m
//  PlantTower0.1
//
//  Created by nomis on 5/23/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import "LoadingScene.h"
#import "GameDefine.h"
#import "MainLayer.h"
#import "GameScene.h"
#import "SelectScene.h"
@implementation LoadingScene
@synthesize sceneTarget;

+(id) sceneWithTargetScene : (int) target{
    return [[[self alloc]initWithTargetScene:target]autorelease] ;
}
-(id) initWithTargetScene : (int) target{
    self = [super init];
    if(self){
        CGSize size = [[CCDirector sharedDirector]winSize];
        sceneTarget = target;
        CCLabelTTF *ttf = [CCLabelTTF labelWithString:@"loading" fontName:@"Marker Felt" fontSize:64.0f];
        ttf.position = ccp(size.width/2 , size.height/2);
        [self addChild:ttf];
    }
    return self;
}
-(void)onEnterTransitionDidFinish{
    [super onEnterTransitionDidFinish];
    [self scheduleUpdate];

}
-(void)update : (ccTime)delta{
    [self unscheduleAllSelectors];
    switch (sceneTarget) {
            
        case GAME_SCENE_INIT:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainLayer scene]]];
            CCLOG(@"ENTER TO GAME_SCENE_INIT");
            break;
        case GAME_SCENE_SELECTCHAPTER:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SelectScene scene]]];
            break;
        case GAME_SCENE_PLAY:
            CCLOG(@"ENTER TO GAME_SCENE_PLAY");

            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene scene]]];
            break;
            
        default:
            break;
    }
}
@end
