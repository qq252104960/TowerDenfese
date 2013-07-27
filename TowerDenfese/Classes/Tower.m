//
//  Tower.m
//  TowerDenfese
//
//  Created by NOMIS on 6/24/13.
//  Copyright (c) 2013 nomis. All rights reserved.
//
#define GAME_TOWER_NORMAL_FRAME_COUNT 16
#define GAME_TOWER_ATTACK_FRAME_COUNT 13

#define GAME_TAG_TOWER_ACTION_NORMAL 1
#define GAME_TAG_TOWER_ACTION_ATTACK 2

#import "Tower.h"
#import "Projectile.h"
#import "GameDefine.h"
@implementation Tower

@synthesize globalData;
@synthesize gameData;

@synthesize towerId;
@synthesize towerName;
@synthesize attackDamage;
@synthesize attackRange;
@synthesize attackSpeed;
@synthesize spriteName;
@synthesize normalFrame;
@synthesize isAttacking;
@synthesize attackDelay;
@synthesize nextLevels;
@synthesize targetCreep;

-(id) initWithTowerIndex : (int)index{
    self = [super init];
    if(self){
        globalData = [GlobalData sharedInstance];
        gameData = [GameData sharedInstance];
        
        NSDictionary *dic = [globalData.allTowers objectAtIndex:index];
        towerId = [[dic valueForKey:@"towerId"]intValue];
        towerName = [dic valueForKey:@"towerCurrectName"];
        spriteName = [dic valueForKey:@"towerName"];
        attackDamage = [[dic valueForKey:@"attackDamage"]intValue];
        attackSpeed = [[dic valueForKey:@"attackSpeed"]floatValue];
        attackRange = [[dic valueForKey:@"attackRange"]intValue];
        nextLevels = [dic valueForKey:@"nextLevel"];
        
        isAttacking = false;
        attackDelay = 0;
        targetCreep = nil;
        
        normalFrame = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@/0000" , spriteName]];
        normalFrame.anchorPoint = ccp(0.5 , 0);
        normalFrame.position = [globalData ccp:0 :-9];
        [self addChild:normalFrame];
        [self normalState];
        [self scheduleUpdate];
        
    }
    return self;
    
}

-(void)normalState{
    [normalFrame stopActionByTag:GAME_TAG_TOWER_ACTION_ATTACK];
    
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    NSMutableArray *frames = [NSMutableArray array];
    for(int i = 0; i<GAME_TOWER_NORMAL_FRAME_COUNT;i++){
        NSString *fileName;
        if(i<10)
            fileName= [NSString stringWithFormat:@"%@/000%d" , spriteName , i];
        else{
            fileName = [NSString stringWithFormat:@"%@/00%d" , spriteName , i ];
        }
        [frames addObject:[frameCache spriteFrameByName:fileName]];
    }
    
    CCAnimation* anim = [CCAnimation animationWithSpriteFrames:frames delay:0.042];
    CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
    CCRepeatForever* actBody = [CCRepeatForever actionWithAction:animate];
    actBody.tag = GAME_TAG_TOWER_ACTION_NORMAL;
    [normalFrame runAction:actBody];
}
-(void)attackState{
    [normalFrame stopActionByTag:GAME_TAG_TOWER_ACTION_NORMAL];
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    NSMutableArray *frames = [NSMutableArray array];
    for(int i = 0; i<GAME_TOWER_ATTACK_FRAME_COUNT;i++){
        NSString *fileName;
        if(i<10)
            fileName= [NSString stringWithFormat:@"%@_attack/000%d" , spriteName , i];
        else{
            fileName = [NSString stringWithFormat:@"%@_attack/00%d" , spriteName , i ];
        }
        [frames addObject:[frameCache spriteFrameByName:fileName]];
    }
    
    CCAnimation* anim = [CCAnimation animationWithSpriteFrames:frames delay:0.042];
    CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
    //CCRepeatForever* actBody = [CCRepeatForever actionWithAction:animate];
    animate.tag = GAME_TAG_TOWER_ACTION_ATTACK;
    isAttacking = false;
    [normalFrame runAction:animate];
    
    
}
-(void)update:(ccTime)delta{
    if(targetCreep != nil){
        if(targetCreep.position.x < self.position.x){
            self.normalFrame.flipX = YES;
        }
        else{
            self.normalFrame.flipX = NO;
        }
    }
    if(!isAttacking){
        for(int i = 0 ; i< [gameData.creeps count];i++){
            Creep *temp = [gameData.creeps objectAtIndex:i];
            if (ccpDistance(temp.position, self.position) < attackRange*globalData.winScale + (temp.contentSize.width+temp.contentSize.height)/4){
                targetCreep =   temp;
                [self attackState];
                
                Projectile* projectile = [[[Projectile alloc]initWithTowerIndex:towerId :i]autorelease];
                projectile.position = self.position;
                
                [temp loseLife:attackDamage];
                [gameData.baseLayer addChild:projectile z:GAME_LAYER_BASE_PROJECTILE];
                [gameData.projectiles addObject:projectile];
                
                attackDelay = 1/attackSpeed;
                isAttacking = true;
                break;
            }
        }
    }
    else{
        attackDelay -= delta;
        if (attackDelay < 0)
        {
            isAttacking = false;
            [self normalState];
        }
    }
}

-(void)draw{
    ccDrawColor4F(0, 0, 0, 1);
    ccDrawCircle(CGPointZero, attackRange*globalData.winScale, 360, 50, NO);
    ccDrawColor4F(1, 1, 1, 1);
}

@end
