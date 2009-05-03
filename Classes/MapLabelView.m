//
//  MapLabelView.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/4/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "MapLabelView.h"
#import "LocatableModelObject.h"
#import <QuartzCore/CALayer.h>
#import "UIColor+Components.h"

@implementation MapLabelView


-(id)initWithFrame:(CGRect)frame andObject:(LocatableModelObject*)object withBottomNub:(BOOL)bottomNub andNubPosition:(CGFloat)nubPos
{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		mObject = object;
		mNubOnBottom = bottomNub;
		mNubPosition = nubPos;
		mNibItems = [[[NSBundle mainBundle] loadNibNamed:@"MapLabelView" owner:self options:nil] retain];
		mLabelText.text = [object briefDescription];
		self.opaque = NO;
		CGRect newFrame = mLabelView.frame;
		newFrame.origin = bottomNub ? CGPointMake(0,0) : CGPointMake(0,8);	// Offset if we're drawing a top nub.
		newFrame.size = CGSizeMake(frame.size.width, mLabelView.frame.size.height);
		mLabelView.frame = newFrame;
		[self addSubview:mLabelView];

		[mInfoButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	CGContextRef ctx = UIGraphicsGetCurrentContext(); 
	CGRect bounds = self.bounds;

	// Convert NUB position to local coordinates:
	CGPoint nubPoint = CGPointMake(mNubPosition, mNubPosition);
	nubPoint = [self convertPoint:nubPoint fromView:self.superview];
	CGFloat nubPos = nubPoint.x;
	
	if (mNubOnBottom)
	{
		// Draw the nub.
		CGContextMoveToPoint(ctx, nubPos, bounds.origin.y + bounds.size.height);
		CGContextAddLineToPoint(ctx, nubPos - 10, (bounds.origin.y + bounds.size.height) - 10);
		CGContextAddLineToPoint(ctx, nubPos + 10, (bounds.origin.y + bounds.size.height) - 10);
		CGContextAddLineToPoint(ctx, nubPos, bounds.origin.y + bounds.size.height);
		CGContextSetFillColor(ctx, [[UIColor colorWithWhite:0.0 alpha:1.0] components]);
		CGContextFillPath(ctx);
		CGContextStrokePath(ctx);
	}
	else
	{
		
	}
}


- (void)dealloc {
	[mInfoButton removeTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchDown];
 	[mNibItems autorelease];
	[super dealloc];
}

-(void)setClickTarget:(id)target andSelector:(SEL)selector
{
	mClickTarget = target;
	mClickSelector = selector;
}

-(void)onClick:(id)sender
{
	[mClickTarget performSelector:mClickSelector withObject:mObject];
}
@end
