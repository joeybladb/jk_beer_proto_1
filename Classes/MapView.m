//
//  MapView.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/2/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "MapView.h"
#import "LocatableModelObject.h"
#import "LocatableObjectView.h"
#import "FestivalDatabase.h"
#import "ExpandingCircle.h"
#import <QuartzCore/QuartzCore.h>

@implementation MapView

@synthesize scale=mScale;

+ (Class)layerClass                        // default is [CALayer class]. Used when creating the underlying layer for the view.
{
	return [CATiledLayer class];
}

-(MapController*)controller
{
	return mController;
}

-(void)setController:(MapController*)controller
{
	mController = controller;
}

-(id) initWithGeometry:(SMapCanvasGeometryDescriptor)geo
{
    if (self = [super initWithFrame:geo.viewFrame]) {
        // Initialization code
		mScale = 1.0;
		// Populate the map with map objects
//		NSArray* locs = [[FestivalDatabase sharedDatabase] locatables];
//		LocatableModelObject* l;
//		NSEnumerator* e = [locs objectEnumerator];
//		while (nil != (l = [e nextObject]))
//			[[LocatableObjectView alloc]intiWithObject:l forMapView:self];	// This will create and insert new map objects.
    }
    return self;
}


- (void)drawRect:(CGRect)rect 
{
	SMapCanvasGeometryDescriptor geo = [[MapController activeMapController] geometry];
	geo.localViewFrame = CGRectZero;

	CGFloat xTran = CGRectGetMidX(self.bounds), yTran = CGRectGetMidY(self.bounds);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ctx);

	CGContextTranslateCTM(ctx, xTran, yTran);
	CGContextRotateCTM(ctx, DegreesToRadians(geo.rotationDegrees));
	CGContextTranslateCTM(ctx, -xTran, -yTran);

	NSArray* locs = [[FestivalDatabase sharedDatabase] locatables];
	LocatableModelObject* l;
	NSEnumerator* e = [locs objectEnumerator];
	while (nil != (l = [e nextObject]))
	{
		[[l shape] renderInContext:ctx withGeometry:geo andScale:mScale];
	}
	
	CGContextRestoreGState(ctx);
}


- (void)dealloc 
{
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    NSUInteger numTaps = [touch tapCount];
    if (numTaps < 2) 
	{
		CGPoint l = [touch locationInView:self];
		CGRect r = CGRectMake(l.x - 2, l.y - 2, 2, 2);
		ExpandingCircle* ep = [[[ExpandingCircle alloc] initWithFrame:r] autorelease];
		[self addSubview:ep];
		[ep	expandToNothing];
	} 
	else	// TODO: implement double-click zoom in on spot.
		[self.nextResponder touchesBegan:touches withEvent:event];
}

@end
