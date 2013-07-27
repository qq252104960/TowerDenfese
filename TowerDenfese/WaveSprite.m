//
//  WaveSprite.m
//  TowerDenfese
//
//  Created by NOMIS on 6/28/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import "WaveSprite.h"

#define GAME_TAG_TTF_WAVE 1012

@implementation WaveSprite
@synthesize waveCount;
-(id)initWithSpriteFrameName:(NSString *)spriteFrameName : (int)wave{
    [super initWithSpriteFrameName:spriteFrameName];
    if(self){
        waveCount = wave;
        NSString *num = [NSString stringWithFormat:@"1/%d" , waveCount];
        GlobalData *globalData = [GlobalData sharedInstance];
        CCLabelTTF* label = [CCLabelTTF labelWithString:num fontName:@"Helvetica" fontSize:[globalData fontSize:10]];
        label.position = [globalData ccp:40 :10];
        
        label.tag = GAME_TAG_TTF_WAVE;
        [self addChild:label];
        
    }
    return self;
}
-(void)addWave : (int)wave{
    
    NSString *num = [NSString stringWithFormat:@"%d/%d" , wave , waveCount];
    
    [self removeChildByTag:GAME_TAG_TTF_WAVE];
    GlobalData *globalData = [GlobalData sharedInstance];
    CCLabelTTF* label = [CCLabelTTF labelWithString:num fontName:@"Helvetica" fontSize:[globalData fontSize:10]];
    label.position = [globalData ccp:40 :10];
    
    label.tag = GAME_TAG_TTF_WAVE;
    [self addChild:label];
    
}

@end
