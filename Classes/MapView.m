//
//  MapView.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/2/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "MapView.h"
#import "MapObject.h"
#import "FestivalDatabase.h"


@implementation MapView

@synthesize canvasRect=mCanvasRect;
@synthesize scale=mScale;

-(MapController*)controller
{
	return mController;
}

-(void)setBackgroundShape:(Shape*)s
{
	mBackgroundShape = [s retain];
}

-(void)setController:(MapController*)controller
{
	mController = controller;
}

- (id)initWithFrame:(CGRect)frame andCanvasRect:(CGRect)canvas {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		mScale = 1.0;
		mCanvasRect = canvas;
		// Populate the map with map objects
		NSArray* locs = [[FestivalDatabase sharedDatabase] locatables];
		LocatableModelObject* l;
		NSEnumerator* e = [locs objectEnumerator];
		while (nil != (l = [e nextObject]))
			[[MapObject alloc]intiWithObject:l forMapView:self];	// This will create and insert new map objects.
    }
    return self;
}


- (void)drawRect:(CGRect)rect 
{
    CGContextRef ctx = UIGraphicsGetCurrentContext(); 
	[mBackgroundShape renderInContext:ctx withViewFrame:self.canvasRect andScale:self.scale];
}


- (void)dealloc {
    [super dealloc];
}

- (void)setTransformWithoutScaling:(CGAffineTransform)newTransform;
{
    [super setTransform:newTransform];
}

- (void)setTransform:(CGAffineTransform)newValue;
{
    [super setTransform:CGAffineTransformScale(newValue, 1.0f / mScale, 1.0f / mScale)];
}

@end
