//
//  MapObject.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/4/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "MapObject.h"
#import "MapView.h"
#import "FestivalDatabase.h"
#import "LocatableModelObject.h"

@implementation MapObject


-(id)intiWithObject:(LocatableModelObject*)object forMapView:(MapView*)map	// Call this to create our state based on the object, and inserted into the map.
{
	// First figure out our frame size -- we'll ask the locatable object for our shape, which we can use to figure out the entirety of our frame.
	// For now, we'll just fudge some numbers.
	CGRect frame, canvasRect = ((MapView*)self.superview).canvasRect;
	Shape* shape = object.shape;
	if (shape)
	{
		frame  = [shape enclosingViewRectangeForCanvasRect:canvasRect];	
	}
	else
	{	// this is temporary -- we'll soon describe images using Shapes.
		frame.origin = [object imageLocation];
		UIImage* img = [UIImage imageNamed:[object imageName]];
		frame.size = img.size;
		mCachedImage = [img retain];
	}

	if (self = [super initWithFrame:frame])
	{
		mModelObject = object;	// don't retain it. the model will most likely outlive us.
		[map addSubview:self];
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	Shape* shape = mModelObject.shape;
	if (shape)
	{	// If we've got a shape, draw it.
		CGContextRef ctx = UIGraphicsGetCurrentContext();
		CGRect canvasRect = ((MapView*)self.superview).canvasRect;
		[shape renderInContext:ctx withViewFrame:canvasRect];
	}
	else	
		[mCachedImage drawAtPoint:CGPointMake(0,0)];
}


- (void)dealloc {
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    NSUInteger numTaps = [touch tapCount];
    if (numTaps < 2) 
	{
		MapView* superView = (MapView*) self.superview;
		[[superView controller] objectClicked:self];
        //[self.nextResponder touchesBegan:touches withEvent:event];
	} 
}

-(LocatableModelObject*)modelObject
{
	return mModelObject;
}

@end
