//
//  Wave.m
//  TowerDenfese
//
//  Created by NOMIS on 6/28/13.
//  Copyright (c) 2013 nomis. All rights reserved.
//

#import "Wave.h"

@implementation Wave
@synthesize creepID;

@synthesize pathNo;
-(id)initWithCreepId : (int)CreepIndex withPathNo:(int)PathNo{
    self = [super init];
    if(self){
        creepID = CreepIndex;
        pathNo = PathNo;
    }
    return self;
}
@end
