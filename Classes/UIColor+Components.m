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

-(NSDictionary*) componentsDescription
{
	NSArray* componentArray = [NSArray array];
	CGColorSpaceRef space = CGColorGetColorSpace(self.CGColor);
	size_t i = 0, numComponents = CGColorGetNumberOfComponents(self.CGColor);
	const CGFloat* components = [self components];
	for (i = 0; i < numComponents; i++)
	{
		componentArray = [componentArray arrayByAddingObject:[NSNumber numberWithFloat:components[i]]];
	}
	NSLog(@"ColorSpace = %@", [(id) space description]);
	return [NSDictionary dictionaryWithObjectsAndKeys:componentArray, @"components", @"NSColorSpaceWtfID", @"colorspace", nil];
}

@end

