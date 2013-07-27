//
//  WayPoint.m
//  TowerDenfese
//
//  Created by NOMIS on 6/24/13.
//  Copyright (c) 2013 nomis. All rights reserved.
//

#import "WayPoint.h"

@implementation WayPoint
@synthesize x;
@synthesize y;
-(id) initWithX : (int)px withY:(int)py
{
    self = [super init];
    if (self) {
        x = px;
        y = py;
    }
    return self;
}
@end
