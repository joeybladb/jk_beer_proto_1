//
//  MeView.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 5/2/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "MeView.h"
#import "UIColor+Components.h"
#import "ExpandingCircle.h"

@implementation MeView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
		mECTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(ecTimer:) userInfo:self repeats:YES];
    }
    return self;
}

#define SMALL_CIRCLE_DIAMETER	6.0
#define LARGE_CIRCLE_INSET		2.0

- (void)drawRect:(CGRect)rect {
    // Drawing code
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGRect smallCenterRect = CGRectMake(CGRectGetMidX(self.bounds) - SMALL_CIRCLE_DIAMETER/2, CGRectGetMidY(self.bounds) - SMALL_CIRCLE_DIAMETER/2, SMALL_CIRCLE_DIAMETER, SMALL_CIRCLE_DIAMETER);
	CGRect largeCenterRect = CGRectInset(self.bounds, LARGE_CIRCLE_INSET, LARGE_CIRCLE_INSET);
	// Draw the large transparent circle:
	CGContextAddEllipseInRect(ctx, largeCenterRect);
	CGContextSetFillColor(ctx, [[UIColor colorWithRed:0.1 green:0.2 blue:1.0 alpha:0.1] components]);
	CGContextFillPath(ctx);
	
	// Draw a smaller filled circle in the middle:
	CGContextAddEllipseInRect(ctx, smallCenterRect);
	CGContextSetFillColor(ctx, [[UIColor blueColor] components]);
	CGContextFillPath(ctx);
}

-(void)ecTimer:(NSTimer*)t
{
	if (self.superview)
	{
		// Set up animated ping! on the center point:
		CGRect r = CGRectMake(self.center.x - 2, self.center.y - 2, 2, 2);
		ExpandingCircle* ep = [[[ExpandingCircle alloc] initWithFrame:r] autorelease];
		[self.superview addSubview:ep];
		[ep	expandToNothing:self.frame.size.width/2];
		NSLog(@"Timer Fired!");
	}
}


- (void)dealloc {
	[mECTimer invalidate];
    [super dealloc];
}


@end
