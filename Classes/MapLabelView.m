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

@implementation MapLabelView


- (id)initWithFrame:(CGRect)frame andObject:(LocatableModelObject*)object
{
	// Oh, so you want that frame do you? Well screw you! I'm going to set the frame to whatever I damned well like. Cause I'm an EVIL view!
	CGSize sz = [[object briefDescription] sizeWithFont:[UIFont systemFontOfSize:14]];
	frame.size = CGSizeMake(sz.width + 32, 28);
	
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		mObject = object;
		mNibItems = [[[NSBundle mainBundle] loadNibNamed:@"MapLabelView" owner:self options:nil] retain];
		mLabelText.text = [object briefDescription];
		self.opaque = NO;
		frame.origin = CGPointMake(0,0);
		mLabelView.frame = frame;
		[self addSubview:mLabelView];
		

		[mInfoButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
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
