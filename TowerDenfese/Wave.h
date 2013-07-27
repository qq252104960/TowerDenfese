//
//  Wave.h
//  TowerDenfese
//
//  Created by NOMIS on 6/28/13.
//  Copyright (c) 2013 nomis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Wave : NSObject
@property int creepID;
@property int pathNo;
-(id)initWithCreepId : (int)CreepIndex withPathNo:(int)PathNo;
@end
