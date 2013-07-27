//
//  GameScene.m
//  TowerDenfese
//
//  Created by NOMIS on 6/18/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import "GameScene.h"
#import "GameUILayer.h"
#import "WayPoint.h"
#import "Wave.h"
#import "GameDefine.h"
#import "MapItem.h"
#import "Hole.h"
#import "Creep.h"
#import "Tower.h"
#import "Projectile.h"
#import "CreateTowerComponent.h"
@implementation GameScene
@synthesize gameData;
@synthesize globalData;
-(void)dealloc{
    [GameData releaseInstance];
    [super dealloc];
}
+(CCScene*) scene{
    CCScene *scene = [CCScene node];
    
    GameScene *layer = [GameScene node];
    [scene addChild:layer z:GAME_LAYER_MAP tag:GAME_TAG_LAYER_MAP];
    
    GameUILayer *uiLayer = [GameUILayer node];
    [scene addChild:uiLayer z:GAME_LAYER_UI tag:GAME_TAG_LAYER_UI];
    return scene;
}
- (id)init
{
    self = [super init];
    if (self) {
        [self setTouchEnabled:YES];
        globalData = [GlobalData sharedInstance];
        gameData = [GameData sharedInstance];
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"map%d.png", globalData.selectMap ]];
        background.position = [globalData ccp:[globalData winSize].width/2 :[globalData winSize].height/2 ];
        [self addChild:background z:GAME_LAYER_MAP];
        [self addChild:gameData.baseLayer z:GAME_LAYER_BASE tag:GAME_TAG_LAYER_BASE];

        
        for(NSDictionary *temp in gameData.mapItems){
            MapItem *mapItem = [[MapItem alloc]initWithItemId:[[temp valueForKey:@"ItemId"]intValue] withX:[[temp valueForKey:@"x"]intValue] withY:[[temp valueForKey:@"y"]intValue]];
            [gameData.baseLayer addChild:mapItem z:GAME_LAYER_BASE_OBJECT];
        }
        CCSprite *countDownSprite = [CCSprite spriteWithSpriteFrameName:@"Game_CountDown/0000"];
        countDownSprite.position = [globalData ccpCenter];
        [self addChild:countDownSprite];
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        
        NSMutableArray *frames = [NSMutableArray array];
        for(int i = 0; i<83;i++){
            NSString *fileName;
            if(i<10)
                fileName= [NSString stringWithFormat:@"Game_CountDown/000%d" , i];
            else{
                fileName = [NSString stringWithFormat:@"Game_CountDown/00%d" , i ];
            }
            [frames addObject:[frameCache spriteFrameByName:fileName]];
        }
        
        CCAnimation* anim = [CCAnimation animationWithSpriteFrames:frames delay:0.042];
        CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
        id action = [CCSequence actions:animate , [CCCallFunc actionWithTarget:self selector:@selector(gameStart:)], nil];
        [countDownSprite runAction:action];
    }
    return self;
}
-(void)gameStart:(ccTime)delta{
    [self schedule:@selector(generateCreep:) interval:1.0f repeat:[[[gameData waves]objectAtIndex:gameData.wave]count]-1 delay:0];
    [self scheduleUpdate];
   
}
-(void)update:(ccTime)delta{
     [self judgeEndOfWave:delta];
    for(Projectile *projectile in gameData.projectiles){
        [projectile action:delta];
    }
}

-(void)judgeEndOfWave:(ccTime)delta{
    if([gameData.creeps count] == 0 ){
        if(gameData.wave < gameData.waveCount){
    
            if(gameData.nowCreepInWaveIndex == [[[gameData waves]objectAtIndex: gameData.wave-1]count]){
                gameData.nowCreepInWaveIndex = 0;
                [gameData addWave];
                [self schedule:@selector(generateCreep:) interval:1.0f repeat:[[[gameData waves]objectAtIndex:gameData.wave-1]count]-1 delay:0];
            
            }
        }
    }
}
-(void)generateCreep:(ccTime)delta{
    Wave *wave = [[gameData.waves objectAtIndex:gameData.wave-1] objectAtIndex:gameData.nowCreepInWaveIndex];
    Creep* creep = [[Creep alloc]initWithCreepIndex:wave.creepID withPathNo:wave.pathNo];
    [gameData.baseLayer addChild:creep z:GAME_LAYER_BASE_CREEPS];
    [gameData.creeps addObject:creep];
    gameData.nowCreepInWaveIndex++;
}
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch  *touch=[touches anyObject];
	CGPoint  touchLocation= [touch locationInView:[touch view]];
    
    CGPoint  glLocation=[[CCDirector sharedDirector] convertToGL:touchLocation];
    glLocation = [gameData.baseLayer convertToNodeSpace:glLocation];
    CCLOG(@"click %f,%f",glLocation.x,glLocation.y);
    
    for(Hole* hole in gameData.holes){
        if([globalData nodeContainsPoint:hole point:glLocation] && !gameData.isTowerCreateComponentSelect){
            CreateTowerComponent *component = [[CreateTowerComponent alloc]initWithHoleIndex:hole];
            component.position = hole.position;
            [gameData.baseLayer addChild:component z:GAME_LAYER_BASE_TIP tag:GAME_TAG_COMPONENT_CREATE_TOWER];
            gameData.isTowerCreateComponentSelect = true;
            [component release];
        }
        else if(![globalData nodeContainsPoint:[gameData.baseLayer getChildByTag:GAME_TAG_COMPONENT_CREATE_TOWER] point:glLocation] ){
           [gameData.baseLayer removeChildByTag:GAME_TAG_COMPONENT_CREATE_TOWER cleanup:YES];
            gameData.isTowerCreateComponentSelect = false;
        }
        
    }

}

@end
