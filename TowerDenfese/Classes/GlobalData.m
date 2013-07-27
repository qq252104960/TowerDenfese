//
//  GlobalData.m
//  PlantTower0.1
//
//  Created by nomis on 5/14/13.
//  Copyright (c) 2013 nomis. All rights reserved.
//

#import "GlobalData.h"
@implementation GlobalData
@synthesize winScale;
@synthesize winSize;

@synthesize selectMap;
@synthesize selectHero;
@synthesize allCreeps;
@synthesize allHeros;
@synthesize allTowers;
@synthesize allMapItems;
@synthesize gameConfig;

+ (GlobalData *)sharedInstance{
    static dispatch_once_t  onceToken;
    static GlobalData * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[GlobalData alloc] init];
    });
    return sSharedInstance;
}
-(void)dealloc{
    allCreeps = nil , [allCreeps release];
    allHeros = nil , [allHeros release];
    allTowers = nil , [allTowers release];
    allMapItems = nil , [allMapItems release];
    gameConfig = nil , [gameConfig release];
    [super dealloc];
}
-(id)init{
    self = [super init];
    if(self){
        CGSize size = [[CCDirector sharedDirector]winSize];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            winScale = 1;
            winSize = size;
        }
        else {
            winScale = 2;
            winSize = CGSizeMake(size.width/2, size.height/2);
        }
        selectMap = 0;
        selectHero = 0;
        allTowers = [[CCArray alloc]init];
        allCreeps = [[CCArray alloc]init];
        allHeros = [[CCArray alloc]init];
        allMapItems = [[CCArray alloc]init];
        

        //READ GAME CONFIG FILE.
        NSString *configFilePath = [self getConfigFilePath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:configFilePath]) {
            NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"GameConfig" ofType:@"plist"];
            if (defaultStorePath) [fileManager copyItemAtPath:defaultStorePath toPath:configFilePath error:NULL];
        }

        gameConfig = [[NSMutableDictionary alloc]initWithContentsOfFile:[self getConfigFilePath]];
        
        //READ TOWER CONFIG FILE;
        for(NSDictionary* dic in [NSMutableArray arrayWithContentsOfFile:
                                  [[NSBundle mainBundle] pathForResource:
                                   [NSString stringWithFormat:@"TowerConfig"] ofType:@"plist"]])
            [allTowers addObject:dic];
        
        //READ CREEP CONFIG FILE;
        for(NSDictionary* dic in [NSMutableArray arrayWithContentsOfFile:
                                  [[NSBundle mainBundle] pathForResource:
                                   [NSString stringWithFormat:@"CreepConfig"] ofType:@"plist"]])
            [allCreeps addObject:dic];
        
        for(NSDictionary* dic in [NSMutableArray arrayWithContentsOfFile:
                                  [[NSBundle mainBundle] pathForResource:
                                   [NSString stringWithFormat:@"MapItemConfig"] ofType:@"plist"]])
            [allMapItems addObject:dic];
        
        
        //READ THE RESOURCES OF THIS GAME;
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"GameResources.plist"];
        
        //READ THE MAPS RESOURCES OF THIS DEFENSE GAME;
        for(int i = 1;i<2;i++){
            NSString *fileName = [NSString stringWithFormat:@"map%d.plist" , i];
            [frameCache addSpriteFramesWithFile:fileName];
        }
    }
    
    return self;
}
-(CGPoint) ccp : (int)x :(int)y{
    return CGPointMake(x*winScale, y*winScale);
}
-(CGPoint) ccpCenter{
    CGSize size = [[CCDirector sharedDirector]winSize];
    return CGPointMake(size.width/2, size.height/2);
}
-(CGPoint) ccpConvertToGL :(int)x : (int)y{
    return [[CCDirector sharedDirector] convertToGL:CGPointMake(x*winScale, y*winScale)];
}
-(CGSize) spriteSize : (CCSprite*)sprite{
    if(2 == winScale)
        return  CGSizeMake(sprite.contentSize.width/2, sprite.contentSize.height/2);
    else return sprite.contentSize;
}
-(int) fontSize : (int)size{
    if(2 == winScale)
        return size*2;
    else return size;
}


-(int)getCrystalCount{
    return [[gameConfig valueForKey:@"CrystalCount"]intValue];
}
-(void)addCrystalCount:(int)index{
    int temp = index+[self getCrystalCount];
    NSNumber *number = [NSNumber numberWithInt:temp];

    [gameConfig setObject:number forKey:@"CrystalCount"];
    [gameConfig writeToFile:[self getConfigFilePath] atomically:YES];
}
-(bool)lostCrystalCount:(int)index{
    if([self getCrystalCount] > index){
        int temp = [self getCrystalCount] - index;
        NSNumber *number = [NSNumber numberWithInt:temp];
        [gameConfig setObject:number forKey:@"CrystalCount"];
        [gameConfig writeToFile:[self getConfigFilePath] atomically:YES];

        return true;
    }
    else return false;
}

- (NSString*) getConfigFilePath{
    NSString *configFilePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"GameConfig.plist"];
    return configFilePath;
}
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
- (bool)nodeContainsPoint:(CCNode*)node point:(CGPoint)pt
{
    if (pt.x > node.position.x - node.contentSize.width/2
        && pt.x < node.position.x + node.contentSize.width/2
        && pt.y > node.position.y - node.contentSize.height/2
        && pt.y < node.position.y + node.contentSize.height/2)
        return YES;
    else
        return NO;
}
@end
