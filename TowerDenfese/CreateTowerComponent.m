//
//  CreateTowerComponent.m
//  TowerDenfese
//
//  Created by NOMIS on 7/1/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import "CreateTowerComponent.h"
#import "Tower.h"
#import "GameDefine.h"
#define GAME_TOWER_CREATE_FRAME_COUNT 12
@implementation CreateTowerComponent
@synthesize globalData;
@synthesize gameData;
@synthesize hole;
@synthesize items;
-(void)dealloc{
    [items release] , items = nil;
    [super dealloc];
}
- (id)initWithHoleIndex : (Hole*)index;
{
    self = [super init];
    if (self) {
        [self setTouchEnabled:YES];
        globalData = [GlobalData sharedInstance] , gameData = [GameData sharedInstance];
        items = [[CCArray alloc]init];
        CCSprite * sprite = [CCSprite spriteWithSpriteFrameName:@"CreateTower_background.png"];
        [self addChild:sprite];
        hole = index;
         self.contentSize = sprite.contentSize;

        if(-1 == hole.towerIndex) {
            for(int i = 0; i < 3; i++){
            
                CCSprite *temp1 = [CCSprite spriteWithSpriteFrameName:@"CreateTower_towerPlacer.png"];
                if(i ==0)
                    temp1.position = [globalData ccp:-30 :-30];
                else if(i == 1)
                    temp1.position = [globalData ccp:0 :30];
                else if(i == 2)
                    temp1.position = [globalData ccp:30 :-30];
                CCSprite *towerImg1 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@/0000" ,  [[globalData.allTowers objectAtIndex:i] valueForKey:@"towerName"]]];
                towerImg1.scale = 0.5;
                towerImg1.position = [globalData ccp:15 :15];
                
                CCLabelTTF* label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d" , [[[globalData.allTowers objectAtIndex:i] valueForKey:@"towerPrice"]intValue]] fontName:@"Helvetica" fontSize:[globalData fontSize:5]];
                label1.position = [globalData ccp:15 : 3];
                [temp1 addChild:towerImg1];
                [temp1 addChild:label1];
                temp1.tag = i;
                [self addChild:temp1];
                [items addObject:temp1];
            }
        }
        else{

            for(int i = 0; i < [hole.tower.nextLevels count] ;i++){
                CCSprite *temp1 = [CCSprite spriteWithSpriteFrameName:@"CreateTower_towerPlacer.png"];
                if(i ==0)
                    temp1.position = [globalData ccp:0 :30];

                else if(i == 1)
                    temp1.position = [globalData ccp:-30 :-30];

                else if(i == 2)
                    temp1.position = [globalData ccp:30 :-30];
                    
                CCSprite *towerImg1 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@/0000" ,  [[globalData.allTowers objectAtIndex:[[hole.tower.nextLevels objectAtIndex:i]intValue]] valueForKey:@"towerName"]]];
                towerImg1.scale = 0.5;
                towerImg1.position = [globalData ccp:15 :15];
                    
                CCLabelTTF* label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d" , [[[globalData.allTowers objectAtIndex:[[hole.tower.nextLevels objectAtIndex:i]intValue]] valueForKey:@"towerPrice"]intValue]] fontName:@"Helvetica" fontSize:[globalData fontSize:5]];
                label1.position = [globalData ccp:15 : 3];
                [temp1 addChild:towerImg1];
                [temp1 addChild:label1];
                temp1.tag = [[hole.tower.nextLevels objectAtIndex:i]intValue];
                [self addChild:temp1];
                [items addObject:temp1];

            }
            
        }
    }
    return self;
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch  *touch=[touches anyObject];
	CGPoint  touchLocation= [touch locationInView:[touch view]];
    
    CGPoint  glLocation=[[CCDirector sharedDirector] convertToGL:touchLocation];
    glLocation = [self convertToNodeSpace:glLocation];

    for (CCSprite *sprite in items) {
        if([globalData nodeContainsPoint:sprite point:glLocation]){
            id action = [CCCallBlock actionWithBlock:^{
                [self createBaseTower:sprite.tag];
            }];
            [self runAction:action];
        }
    }
}
-(void)createBaseTower:(int)index{
    Tower *tower = [[Tower alloc]initWithTowerIndex:index];
    tower.position = hole.position;
    
    //    if(hole.type == 1){
    //    }
    //    else if(hole.type ==0){
    //        tower.position = ccp(hole.position.x, hole.position.y+20*globalData.winScale);
    //    }

    if(hole.isBuilt == YES){
        [gameData.baseLayer removeChild:hole.tower cleanup:YES];
        [gameData.baseLayer addChild:tower z:GAME_LAYER_BASE_TOWERS];
        [gameData.towers addObject:tower];

    }
    else{
        CCSprite *normalFrame = [CCSprite spriteWithSpriteFrameName:@"smog_small/0000"];
        normalFrame.position = hole.position;
        [gameData.baseLayer addChild:normalFrame z:GAME_LAYER_BASE_TIP];
        
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        NSMutableArray *frames = [NSMutableArray array];
        
        for(int i = 0; i<GAME_TOWER_CREATE_FRAME_COUNT;i++){
            NSString *fileName;
            if(i<10) fileName= [NSString stringWithFormat:@"smog_small/000%d" , i];
            else fileName = [NSString stringWithFormat:@"smog_small/00%d" , i];
            [frames addObject:[frameCache spriteFrameByName:fileName]];
        }
        
        CCAnimation* anim = [CCAnimation animationWithSpriteFrames:frames delay:0.042];
        CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
        id action = [CCSequence actions:animate ,
                     [CCCallBlock actionWithBlock:^{
            [gameData.baseLayer removeChild:normalFrame];
        }], nil];
        [normalFrame runAction:action];
        [gameData.baseLayer addChild:tower z:GAME_LAYER_BASE_TOWERS];
        [gameData.towers addObject:tower];
    }
    [gameData.baseLayer removeChildByTag:GAME_TAG_COMPONENT_CREATE_TOWER cleanup:YES];

    [tower release];
    hole.towerIndex = index;
    hole.tower = tower;
    hole.isBuilt = YES;
}
@end
