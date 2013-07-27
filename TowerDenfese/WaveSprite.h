//
//  WaveSprite.h
//  TowerDenfese
//
//  Created by NOMIS on 6/28/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GlobalData.h"
#import "GameDefine.h"
@interface WaveSprite : CCSprite {
    
}
@property int waveCount;
-(id)initWithSpriteFrameName:(NSString *)spriteFrameName : (int)wave;
-(void)addWave:(int)wave;
@end
