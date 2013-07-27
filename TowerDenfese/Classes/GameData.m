//
//  GameData.m
//  TowerDenfese
//
//  Created by NOMIS on 6/23/13.
//  Copyright (c) 2013 nomis. All rights reserved.
//

#import "GameData.h"
#import "GlobalData.h"
#import "GameDefine.h"
#import "GameUILayer.h"
#import "WaveSprite.h"
#import "MoneySprite.h"
#import "GameWinLayer.h"
#import "GameFailedLayer.h"
#import "MapItem.h"
#import "Wave.h"
#import "WayPoint.h"
#import "Hole.h"


@implementation GameData
@synthesize life;
@synthesize fullLife;
@synthesize money;
@synthesize waveCount;
@synthesize projectiles;

@synthesize towers;
@synthesize creeps;
@synthesize wayPoints;
@synthesize wave;
@synthesize waves;
@synthesize nowCreepInWaveIndex;
@synthesize holes;
@synthesize initPoint;
@synthesize targetPoint;
@synthesize mapItems;
@synthesize baseLayer;
@synthesize isTowerCreateComponentSelect;

static dispatch_once_t  onceToken;
static GameData * sSharedInstance;
- (void)dealloc
{
    [projectiles release] , projectiles = nil;
    [wayPoints release] , wayPoints = nil;
    [creeps release] , creeps = nil;
    [towers release] , towers = nil;
    [waves release] , waves = nil;
    [mapItems release] , mapItems = nil;
    [holes release] , holes = nil;
    [super dealloc];
}
+ (GameData *)sharedInstance{
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[GameData alloc] init];
    });
    return sSharedInstance;
}
+ (void)releaseInstance{
    onceToken = nil;
    [sSharedInstance release] , sSharedInstance = nil;
}

- (id)init
{
    self = [super init];
    if (self) {

        GlobalData *globalData = [GlobalData sharedInstance];
        baseLayer = [CCNode node];
        baseLayer.anchorPoint = ccp(0.5 , 0.5);
        baseLayer.contentSize = CGSizeMake(480*globalData.winScale, 320*globalData.winScale);
        baseLayer.position = [globalData ccpCenter];
        
        
        money = 0;
        fullLife = GAME_LIFE;
        life = fullLife;
        wave = 1;
        waveCount = 0;
        nowCreepInWaveIndex = 0;
        isTowerCreateComponentSelect = false;
        
        projectiles = [[CCArray alloc]init];
        wayPoints = [[CCArray alloc]init];
        creeps = [[CCArray alloc]init];
        towers = [[CCArray alloc]init];
        waves = [[CCArray alloc]init];
        holes = [[CCArray alloc]init];
        mapItems = [[CCArray alloc]init];

                
        NSString *fileName = [NSString stringWithFormat:@"map%d-config" , globalData.selectMap];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        
        [self setMoney:[[dic valueForKey:@"InitMoney"]intValue]];
        

        NSArray *wavesTemp = [dic valueForKey:@"Waves"];
        [self setWaveCount:[wavesTemp count]];
        
        
        for(NSArray *temp in wavesTemp){
            NSMutableArray *temp3 = [[NSMutableArray alloc]init];
            for(NSDictionary *temp2 in temp){
                Wave *waveTemp = [[Wave alloc]initWithCreepId:[[temp2 valueForKey:@"creepId"]intValue] withPathNo:[[temp2 valueForKey:@"pathNo"]intValue]];
                [temp3 addObject:waveTemp];
            }
            [waves addObject:temp3];
        }
    
        NSArray *holesTemp = [dic valueForKey:@"Hole"];
        for(NSDictionary *temp in holesTemp){
            int x = [[temp valueForKey:@"x" ]intValue];
            int y = [[temp valueForKey:@"y" ]intValue];
            Hole *hole = [[Hole alloc]initWithType:[[temp valueForKey:@"type"]intValue] ];
            hole.position = [globalData ccp:x :y];
            [holes addObject:hole];
            [baseLayer addChild:hole];
            [hole release];
        }
        
        NSArray *mapItemsTemp = [dic valueForKey:@"MapItem"];
        for(NSDictionary *temp in mapItemsTemp){
            [mapItems addObject:temp];
        }
        
        NSDictionary *initPointDic = [dic valueForKey:@"InitPoint"];
        NSDictionary *targetPointDic = [dic valueForKey:@"TargetPoint"];
        
        initPoint = [globalData ccp:[[initPointDic valueForKey:@"x" ]intValue] : [[initPointDic valueForKey:@"y" ]intValue]];
        targetPoint = [globalData ccp:[[targetPointDic valueForKey:@"x" ]intValue] : [[targetPointDic valueForKey:@"y" ]intValue]];
        
        CCSprite *initPointSprite = [CCSprite spriteWithSpriteFrameName:@"InitPoint.png"];
        CCSprite *targetPointSprite = [CCSprite spriteWithSpriteFrameName:@"TargetPoint.png"];
        initPointSprite.position = initPoint;
        targetPointSprite.position = targetPoint;
        initPointSprite.anchorPoint = ccp(0.5 , 0);
        targetPointSprite.anchorPoint = ccp(0.5 , 0);
        [baseLayer addChild:initPointSprite z:GAME_LAYER_BASE_OBJECT];
        [baseLayer addChild:targetPointSprite z:GAME_LAYER_BASE_OBJECT];
        
        
        
        NSArray *wayPointArray = [dic valueForKey:@"Path"];
        for(NSArray *temp in wayPointArray){
            NSMutableArray *arrayTemp = [[NSMutableArray alloc]init];
            for(NSDictionary* temp2 in temp){
                WayPoint *wayPoint = [[WayPoint alloc]initWithX:[[temp2 valueForKey:@"x"]intValue] withY:[[temp2 valueForKey:@"y"]intValue]];
                [arrayTemp addObject:wayPoint];
            }
            [wayPoints addObject:arrayTemp];
            [arrayTemp release];
        }
    }
    return self;
}
- (void)loseLife:(int)index{
    life = life - index;
    if(life <= 0){
        GameFailedLayer *scene = [GameFailedLayer node];
        [[[CCDirector sharedDirector]runningScene] addChild:scene z:GAME_LAYER_ALERT tag:GAME_TAG_LAYER_FAILED];
        
    }
}
- (void)addMoney:(int)index{
    money = index+money;
    GameUILayer *scene = (GameUILayer*)[[[CCDirector sharedDirector]runningScene] getChildByTag:GAME_TAG_LAYER_UI];
    MoneySprite *moneySprite = (MoneySprite*)[scene getChildByTag:GAME_TAG_SPRITE_MONEY];
    [moneySprite changeMoney:money];
}
- (bool)loseMoney:(int)index{
    if(money >index){
        money = money-index;
        GameUILayer *scene = (GameUILayer*)[[[CCDirector sharedDirector]runningScene] getChildByTag:GAME_TAG_LAYER_UI];
        MoneySprite *moneySprite = (MoneySprite*)[scene getChildByTag:GAME_TAG_SPRITE_MONEY];
        [moneySprite changeMoney:money];
        return true;
    }
    else return false;
}
- (bool)isMoneyEnough :(int)index{
    if(money>=index) return true;
    else return false;
}
- (void)addWave{
    wave = wave+1;
    if(wave <= waveCount){
        GameUILayer *scene = (GameUILayer*)[[[CCDirector sharedDirector]runningScene] getChildByTag:GAME_TAG_LAYER_UI];
        WaveSprite *waveSprite = (WaveSprite*)[scene getChildByTag:GAME_TAG_SPRITE_WAVE];
        [waveSprite addWave:wave];
    }
    else{
        [[CCDirector sharedDirector]pause];
        GameWinLayer *scene = [GameWinLayer node];
        [[[CCDirector sharedDirector]runningScene] addChild:scene z:GAME_LAYER_ALERT tag:GAME_TAG_LAYER_WIN];
    }
    
}

@end
