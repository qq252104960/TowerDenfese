//
//  Creep.m
//  TowerDenfese
//
//  Created by NOMIS on 6/28/13.
//  Copyright 2013 nomis. All rights reserved.
//
#define GAME_TAG_CREEP_WALK 1
#define GAME_TAG_CREEP_NORMAL 2

#define GAME_CREEP_DIE_FRAME_COUNT  12
#define GAME_CREEP_WALK_FRAME_COUNT 6

#import "Creep.h"


@implementation Creep

@synthesize globalData;
@synthesize gameData;

@synthesize creepId;
@synthesize creepName;
@synthesize spriteName;
@synthesize magicDenfense;
@synthesize physicalDenfense;
@synthesize hpMax;
@synthesize hpNow;
@synthesize speed;
@synthesize loseOfLife;
@synthesize normalFrame;
@synthesize pathNo;
@synthesize isDead;

@synthesize nowPosition;
@synthesize nextPosition;
@synthesize nowWayPointIndex;
@synthesize bloodProgress;
-(id) initWithCreepIndex :(int) index withPathNo : (int)PathNo{
    [super init];
    if(self){
        globalData = [GlobalData sharedInstance];
        gameData = [GameData sharedInstance];
        NSDictionary *dic = [globalData.allCreeps objectAtIndex:index];
        creepId = [[dic valueForKey:@"creepId"]intValue];
        creepName = [dic valueForKey:@"creepCurrectName"];
        spriteName = [dic valueForKey:@"creepName"];
        hpMax = [[dic valueForKey:@"hp"]intValue];
        hpNow = hpMax;
        speed = [[dic valueForKey:@"speed"]intValue]*globalData.winScale;
        physicalDenfense = [[dic valueForKey:@"physicalDefenseLevel"]intValue];
        magicDenfense = [[dic valueForKey:@"magicDefenseLevel"]intValue];
        loseOfLife = [[dic valueForKey:@"loseOfLife"]intValue];
        
        pathNo = PathNo;
        nowWayPointIndex = 0 ;
        
        isDead = NO;
        
        nowPosition = [[[gameData wayPoints] objectAtIndex:pathNo]objectAtIndex:nowWayPointIndex];
        nextPosition = [[[gameData wayPoints] objectAtIndex:pathNo ] objectAtIndex: nowWayPointIndex+1];
        
        NSString *fileName= [NSString stringWithFormat:@"%@/0000" , spriteName];
        normalFrame = [CCSprite spriteWithSpriteFrameName:fileName];
        self.contentSize = normalFrame.contentSize;
        self.position = [globalData ccp:nowPosition.x :nowPosition.y ];
         [self addChild:normalFrame];
        
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        NSMutableArray *frames = [NSMutableArray array];
        for(int i = 0; i<GAME_CREEP_WALK_FRAME_COUNT;i++){
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
        actBody.tag = GAME_TAG_CREEP_WALK;
        [normalFrame runAction:actBody];
        
        
        //        CCSprite* CreepBloodBackBar = [CCSprite spriteWithSpriteFrameName:@"CreepProgressBar_gray.png"];
        //        CreepBloodBackBar.position = ccp(0, normalFrame.contentSize.height/2);
        //        [self addChild:CreepBloodBackBar];
        
        CCSprite* CreepBloodFrontBar = [CCSprite spriteWithSpriteFrameName:@"CreepProgressBar_red.png"];
        bloodProgress = [CCProgressTimer progressWithSprite:CreepBloodFrontBar];
        bloodProgress.type = kCCProgressTimerTypeBar;
        bloodProgress.midpoint = ccp(0,0.5);
        bloodProgress.barChangeRate = ccp(1,0);
        bloodProgress.position = ccp(0, normalFrame.contentSize.height/2);
        bloodProgress.tag = 999;
        bloodProgress.percentage = 100;
        [self addChild:bloodProgress];
        
        
        CGPoint nowPositionPoint = [globalData ccp:nowPosition.x :nowPosition.y];
        CGPoint nextPositionPoint = [globalData ccp:nextPosition.x :nextPosition.y];
        CGPoint moveDifference = ccpSub(nowPositionPoint, nextPositionPoint);
        float distanceToMove = ccpLength(moveDifference);
        float moveDuration = distanceToMove / speed;
        
        if (moveDifference.x <0) normalFrame.flipX = NO;
        else normalFrame.flipX = YES;
        
        
        id action = [CCSequence actions:
                     [CCMoveTo actionWithDuration:moveDuration position:nextPositionPoint],
                     [CCCallFunc actionWithTarget:self selector:@selector(creepMoveEnded)],
                     nil];
        [self runAction:action];
        
    }
    return self;
}
-(void)creepMoveEnded{
    if(nowWayPointIndex <[[gameData.wayPoints objectAtIndex:pathNo ] count]-1){
        nowPosition = nextPosition;
        nowWayPointIndex = nowWayPointIndex + 1;
        nextPosition = [[[gameData wayPoints] objectAtIndex:pathNo]objectAtIndex:nowWayPointIndex];
        
        CGPoint nowPositionPoint = [globalData ccp:nowPosition.x :nowPosition.y];
        CGPoint nextPositionPoint = [globalData ccp:nextPosition.x :nextPosition.y];
        CGPoint moveDifference = ccpSub(nowPositionPoint, nextPositionPoint);
        
        float distanceToMove = ccpLength(moveDifference);
        float moveDuration = distanceToMove / speed;
        
        if (moveDifference.x <0) normalFrame.flipX = NO;
        else normalFrame.flipX = YES;
        id action = [CCSequence actions:
                     [CCMoveTo actionWithDuration:moveDuration position:nextPositionPoint],
                     [CCCallFunc actionWithTarget:self selector:@selector(creepMoveEnded)],
                     nil];
        [self runAction:action];
    }
    else{
        [normalFrame stopActionByTag:GAME_TAG_CREEP_WALK];
        [self removeChild:bloodProgress];
        [self creepDied];
    }
    
}
-(void)creepDied{
    [self stopAllActions];
    [normalFrame stopAllActions];
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    NSMutableArray *frames = [NSMutableArray array];
    
    if(loseOfLife == 1){
        for(int i = 0; i<GAME_CREEP_DIE_FRAME_COUNT;i++){
            NSString *fileName;
            if(i<10) fileName= [NSString stringWithFormat:@"smog_small/000%d" , i];
            else fileName = [NSString stringWithFormat:@"smog_small/00%d" , i];
            [frames addObject:[frameCache spriteFrameByName:fileName]];
        }
    }
    else{
        for(int i = 0; i<GAME_CREEP_DIE_FRAME_COUNT;i++){
            NSString *fileName;
            if(i<10) fileName= [NSString stringWithFormat:@"smog_big/000%d" , i];
            else fileName = [NSString stringWithFormat:@"smog_big/00%d" , i];
            [frames addObject:[frameCache spriteFrameByName:fileName]];
        }
    }
    CCAnimation* anim = [CCAnimation animationWithSpriteFrames:frames delay:0.042];
    CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
    id action = [CCSequence actions:animate ,
                 [CCCallBlock actionWithBlock:^{
        [gameData.creeps removeObject:self];
    }], nil];
    [normalFrame runAction:action];

}
-(void) loseLife : (int)index{
    if (!isDead) {
        hpNow = hpNow - index;
        if(hpNow < 0){
            [self creepDied];
            isDead = YES;
            bloodProgress.percentage = 0;
            
        }
        else{
            float result = (float)hpNow/(float)hpMax;
            bloodProgress.percentage = result*100;
        }

    }
}
-(void) addLife : (int)index{
    if((hpNow + index) >= hpMax)
        hpNow = hpMax;
    else hpNow = hpNow+index;
    bloodProgress.percentage = (hpNow / hpMax)*100;
}

-(void) setState : (int)index{
    
}
-(void) decreaseSpeed : (int)index{}
-(void) increaseSpeed : (int)index{}

-(void) decreasePhysicalDenfense : (int)index{}
-(void) increasePhysicalDenfense : (int)index{}

-(void) decreaseMagicDenfense : (int)index{}
-(void) increaseMagicDenfense : (int)index{}

@end
