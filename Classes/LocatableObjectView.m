//
//  LocatableObjectView.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/4/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "LocatableObjectView.h"
#import "MapView.h"
#import "FestivalDatabase.h"
#import "LocatableModelObject.h"
#import "UIColor+Components.h"

@implementation LocatableObjectView

@synthesize modelObject=mModelObject;

-(id)intiWithObject:(LocatableModelObject*)modelObject forMapView:(MapView*)map	// Call this to create our state based on the object, and inserted into the map.
{
	// First figure out our frame size -- we'll ask the locatable object for our shape, which we can use to figure out the entirety of our frame.
	// For now, we'll just fudge some numbers.
	SMapCanvasGeometryDescriptor geo = [MapController activeMapController].geometry;
	CGRect frame = CGRectMake(0, 0, 10, 10);
	Shape* shape = modelObject.shape;
	
	NSAssert(shape != nil, @"Locatable object with no Shape.");

	frame  = [shape enclosingViewRectangeForGeometry:geo];

	if (self = [super initWithFrame:frame])
	{
		mModelObject = modelObject;	// don't retain it. the model will most likely outlive us.
		[map addSubview:self];
		NSLog(@"### View for \"%@\" added to map: frame=%@ relative to super's bounds=%@", modelObject.name, NSStringFromCGRect(frame), NSStringFromCGRect(map.bounds));
//		self.bounds = frame;
		self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];	// Draw a clear background.
		self.opaque = NO;
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	Shape* shape = mModelObject.shape;
	if (shape)
	{	// If we've got a shape, draw it.
		SMapCanvasGeometryDescriptor geo = [MapController activeMapController].geometry;
		CGContextRef ctx = UIGraphicsGetCurrentContext();
		geo.localViewFrame = self.frame;
		[shape renderInContext:ctx withGeometry:geo andScale:((MapView*)self.superview).scale];
		NSLog(@"### Shape for \"%@\" drawn, bounds=%@, frame=%@", mModelObject.name, NSStringFromCGRect(self.bounds), NSStringFromCGRect(self.frame));
		CGContextSetStrokeColor(ctx, [[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] components]);
		CGContextAddRect(ctx, self.bounds);
		CGContextMoveToPoint(ctx, self.bounds.origin.x, self.bounds.origin.y);
		CGContextAddLineToPoint(ctx, self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y + self.bounds.size.height);
		CGContextMoveToPoint(ctx, self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height);
		CGContextAddLineToPoint(ctx, self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y);

		CGContextStrokePath(ctx);
	}
	else	
		[mCachedImage drawAtPoint:CGPointMake(0,0)];
}


- (void)dealloc {
    [super dealloc];
}


-(void)resizeTo:(SMapCanvasGeometryDescriptor)geometry withScale:(CGFloat)scale	// This is called whenever we get re-scaled, i.e. via our UIScrollView.
{
	Shape* shape = mModelObject.shape;
	CGRect newFrame = [shape enclosingViewRectangeForGeometry:geometry];
	self.frame = newFrame;
	[self setNeedsDisplay];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    NSUInteger numTaps = [touch tapCount];
    if (numTaps < 2) 
	{
		MapView* superView = (MapView*) self.superview;
		if ([mModelObject interactsWithUser])
			[[superView controller] objectClicked:self];
		else
			[[superView controller] objectClicked:nil];
 	} 
	else
		[self.nextResponder touchesBegan:touches withEvent:event];
}
@end
