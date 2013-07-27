//
//  Projectile.m
//  TowerDenfese
//
//  Created by NOMIS on 6/24/13.
//  Copyright (c) 2013 nomis. All rights reserved.
//

#import "Projectile.h"

@implementation Projectile
@synthesize globalData;
@synthesize gameData;
@synthesize towerName;
@synthesize normalFrameCount;
@synthesize effectFrameCount;
@synthesize projectileSpeed;
@synthesize normalSprite;
@synthesize targetCreep;
@synthesize towerIndex;

- (id)initWithTowerIndex:(int)index : (int)targetId{
    self = [super init];
    if(self){
        globalData = [GlobalData sharedInstance];
        gameData = [GameData sharedInstance];
        NSDictionary *dic = [globalData.allTowers objectAtIndex:index];
        towerIndex = index;
        towerName = [dic valueForKey:@"towerName"];
        normalFrameCount = [[dic valueForKey:@"normalFrameCount"]intValue];
        effectFrameCount = [[dic valueForKey:@"effectFrameCount"]intValue];
        projectileSpeed = [[dic valueForKey:@"projectileSpeed"]intValue];
        
        NSString *fileName= [NSString stringWithFormat:@"%@_projectile/0000" , towerName];
        normalSprite = [CCSprite spriteWithSpriteFrameName:fileName];
        self.contentSize = normalSprite.contentSize;
        [self addChild:normalSprite];
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        NSMutableArray *frames = [NSMutableArray array];
        for(int i = 0; i<normalFrameCount;i++){
            NSString *fileName;
            if(i<10)
                fileName= [NSString stringWithFormat:@"%@_projectile/000%d" , towerName , i];
            else{
                fileName = [NSString stringWithFormat:@"%@_projectile/00%d" , towerName , i ] ;
            }
            [frames addObject:[frameCache spriteFrameByName:fileName]];
        }
        
        CCAnimation* anim = [CCAnimation animationWithSpriteFrames:frames delay:0.042];
        CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
        CCRepeatForever *actBody = [CCRepeatForever actionWithAction:animate];
        
        [normalSprite runAction:actBody];
        
        targetCreep = [gameData.creeps objectAtIndex:targetId];
        
        
    }
    return self;
}

- (void)action:(ccTime)delta{
    
    CGPoint v = ccpSub(targetCreep.position, self.position);
    float l = ccpLength(v);
    CGPoint ptV = [globalData ccp:projectileSpeed * v.x/l :projectileSpeed * v.y/l];
    CGPoint ptNow = ccp(self.position.x+delta*ptV.x , self.position.y+delta*ptV.y);
//    CGPoint ptNow = [globalData ccp:self.position.x + delta*ptV.x :self.position.y + delta*ptV.y];
//    
    self.position = ptNow;
    
    if (ccpDistance(ptNow, targetCreep.position) < self.contentSize.width/3 || targetCreep == nil )
    {
        [self projectileMoveEnded];
    }
    
    
}
- (void)projectileMoveEnded{
//    [normalSprite stopAllActions];
    [gameData.baseLayer removeChild:self];
    
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    
    NSMutableArray *frames = [NSMutableArray array];
    for(int i = 0; i<effectFrameCount;i++){
        NSString *fileName;
        if(i<10)
            fileName= [NSString stringWithFormat:@"%@_projectile_effect/000%d" , towerName , i];
        else{
            fileName = [NSString stringWithFormat:@"%@_projectile_effect/00%d" , towerName , i ];
        }
        [frames addObject:[frameCache spriteFrameByName:fileName]];
    }
    
    CCAnimation* anim = [CCAnimation animationWithSpriteFrames:frames delay:0.042];
    CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
    id action = [CCSequence actions:animate ,
                 [CCCallBlock actionWithBlock:^{
        if(towerIndex == 3 || towerIndex==4 || towerIndex ==5){
            [targetCreep setState:0];
        }
        [gameData.projectiles removeObject:self];
    }], nil];
    [normalSprite runAction:action];
    
}


@end
