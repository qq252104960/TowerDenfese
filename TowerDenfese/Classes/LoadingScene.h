//
//  LoadingScene.h
//  PlantTower0.1
//
//  Created by nomis on 5/23/13.
//  Copyright 2013 nomis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LoadingScene : CCLayer {
    
}
@property int sceneTarget;
-(void)update:(ccTime)delta;
+(id) sceneWithTargetScene: (int) target;
-(id) initWithTargetScene : (int) target;
@end
