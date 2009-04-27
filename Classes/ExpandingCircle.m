//
//  ExpandingCircle.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/26/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "ExpandingCircle.h"
#import "UIColor+Components.h"


@implementation ExpandingCircle


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGRect b = self.bounds;
	b = CGRectInset(b, 4, 4);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetFillColor(ctx, [[UIColor colorWithRed:0.0 green:0.2 blue:1.0 alpha:0.5] components]);
	CGContextSetStrokeColor(ctx, [[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0] components]);
	CGContextSetLineWidth(ctx, 8.0);
	CGContextFillEllipseInRect(ctx, b);
	CGContextStrokeEllipseInRect(ctx, b);
}


- (void)dealloc {
    [super dealloc];
}

-(void)expandToNothing
{
#define EXPAND_VALUE 80
	CGPoint p = self.center;
	CGRect newFrame = CGRectMake(p.x - EXPAND_VALUE, p.y - EXPAND_VALUE, EXPAND_VALUE * 2, EXPAND_VALUE * 2);
	[UIView beginAnimations:@"Expando" context:self];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:1.0];
	self.frame = newFrame;
	self.alpha = 0.0;
	[UIView commitAnimations];
}

-(void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[(UIView*)context removeFromSuperview];
}
@end
