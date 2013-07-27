//
//  MoneySprite.m
//  TowerDenfese
//
//  Created by NOMIS on 6/28/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import "MoneySprite.h"

#define GAME_TAG_TTF_MONEY 1012

@implementation MoneySprite

-(id)initWithSpriteFrameName:(NSString *)spriteFrameName : (int)money{
    [super initWithSpriteFrameName:spriteFrameName];
    if(self){
        NSString *num = [NSString stringWithFormat:@"%d" , money];
        GlobalData *globalData = [GlobalData sharedInstance];
        CCLabelTTF* label = [CCLabelTTF labelWithString:num fontName:@"Helvetica" fontSize:[globalData fontSize:10]];
        label.position = [globalData ccp:30 :10];
        
        label.tag = GAME_TAG_TTF_MONEY;
        [self addChild:label];
    }
    return self;
}

-(void)changeMoney : (int) money{
    NSString *num = [NSString stringWithFormat:@"%d" , money];
    [self removeChildByTag:GAME_TAG_TTF_MONEY];
    GlobalData *globalData = [GlobalData sharedInstance];
    CCLabelTTF* label = [CCLabelTTF labelWithString:num fontName:@"Helvetica" fontSize:[globalData fontSize:10]];
    label.position = [globalData ccp:37 :10];
    
    label.tag = GAME_TAG_TTF_MONEY;
    [self addChild:label];
}

@end
