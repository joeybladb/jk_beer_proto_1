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
#import "MyTiledLayer.h"
#import <QuartzCore/QuartzCore.h>

@implementation MapView

@synthesize scale=mScale;

+ (Class)layerClass                        // default is [CALayer class]. Used when creating the underlying layer for the view.
{
	return [MyTiledLayer class];
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

	CGRect someOtherRect = CGContextGetClipBoundingBox(ctx);
	
	NSArray* locs = [[FestivalDatabase sharedDatabase] locatables];
	LocatableModelObject* l;
	NSEnumerator* e = [locs objectEnumerator];
	while (nil != (l = [e nextObject]))
	{
		Shape* shape = [l shape];
		CGRect viewR = [shape enclosingViewRectangeForGeometry:geo];
		if (CGRectIntersectsRect(viewR, someOtherRect))
		{
			[shape renderInContext:ctx withGeometry:geo andScale:mScale];
		}
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
		SMapCanvasGeometryDescriptor geo = [[MapController activeMapController] geometry];
		CGPoint hitPointInViewCoords = [touch locationInView:self];
		NSEnumerator* e = [[[FestivalDatabase sharedDatabase] locatables] objectEnumerator];
		LocatableModelObject* loc;
		while (nil != (loc = [e nextObject]))
		{
			if (CGRectContainsPoint([loc.shape enclosingViewRectangeForGeometry:geo], hitPointInViewCoords))
			{
				if ([loc interactsWithUser])
				{
					[[MapController activeMapController] objectClicked:loc];
					break;
				}
				else
					[[MapController activeMapController] objectClicked:nil];
			}
			
		}
	} 
	else	// TODO: implement double-click zoom in on spot.
		[self.nextResponder touchesBegan:touches withEvent:event];
}

@end
