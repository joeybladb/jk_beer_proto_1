//
//  UIColor+Components.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/4/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "UIColor+Components.h"


@implementation UIColor (Components)
-(const CGFloat*)components
{
	return CGColorGetComponents(self.CGColor);
}
@end

