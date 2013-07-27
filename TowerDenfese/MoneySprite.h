//
//  MoneySprite.h
//  TowerDenfese
//
//  Created by NOMIS on 6/28/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "GameDefine.h"
#import "GlobalData.h"
@interface MoneySprite : CCSprite {
    
}

-(void)changeMoney : (int) money;
-(id)initWithSpriteFrameName:(NSString *)spriteFrameName : (int)money;
@end
