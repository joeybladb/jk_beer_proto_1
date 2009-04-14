//
//  MapController.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 3/29/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "MapController.h"
#import "MapView.h"
#import "MapObject.h"
#import "MapLabelView.h"
#import "BeerController.h"
#import "Shape.h"
#import "UIColor+Components.h"

@implementation MapController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self initFestivalGrounds];

#define CANVAS_INSET 10.0
#define START_WIDTH 300
	
	// Calculate the map view rect and the "canvas" rect. The map objects will live and draw within the "canvas" rect.
	// First pass, assume y > x
	CGRect bounds = [mFestivalGrounds enclosingRectangleShouldFlip:YES rotatingByAngle:(double)0.0];	// This is the rect enclosing the entire festival.
	mOriginalMapFrame = CGRectMake(0, 0, START_WIDTH + CANVAS_INSET * 2.0, START_WIDTH * (bounds.size.height / bounds.size.width) + CANVAS_INSET * 2.0);
	CGRect canvasRect = CGRectInset(mOriginalMapFrame, CANVAS_INSET, CANVAS_INSET);
	
	// Build the map view:
	mMapView = [[MapView alloc] initWithFrame:mOriginalMapFrame andCanvasRect:canvasRect];	// Mapview will automatically populate itself with subviews corresponding to locatable objects in the database.
	mMapView.backgroundColor = [UIColor colorWithRed:.95 green:.95 blue:.81 alpha:1.0];
	[(MapView*)mMapView setController:self];
	[(MapView*)mMapView setBackgroundShape:mFestivalGrounds];
	CGAffineTransform tx = mMapView.transform;
	mMapView.transform = tx;

	// Put the map view IN the scroller, fix up the settings on the scroller.
	mScroller.contentSize = CGSizeMake(mMapView.frame.size.width, mMapView.frame.size.height);
	mScroller.maximumZoomScale = 6.0;
	mScroller.minimumZoomScale = 1.0;
	mScroller.clipsToBounds = YES;
	mScroller.delegate = self;
    [mScroller addSubview:mMapView];
	
	[self scrollViewDidEndZooming:mScroller withView:mMapView atScale:1.0];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//	NSLog(@"Content offset = %@", NSStringFromCGPoint(scrollView.contentOffset));
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView     // return a view that will be scaled. if delegate returns nil, nothing happens
{
	return mMapView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale // scale between minimum and maximum. called after any 'bounce' animations
{
	// UIScrollView will scale the frame size while also scaling the transform. This makes our drawing look horribly blurry and aliased, not to mention we
	// do NOT want the subviews to be scaled like that either.
	// So the trick is to set the transform back to Identity.
	
	// First, grab the scaled frame size, and set the scroller's contentSize to that.
	CGRect bigScaledFrame = mMapView.frame;
	scrollView.contentSize = mMapView.frame.size;
	
	// Set to Identity transform
	[mMapView setTransformWithoutScaling:CGAffineTransformIdentity];
	
	// Now that we're scaling at 1:1, we can set the view's frame BACK to the big scale
	mMapView.frame = bigScaledFrame;
	
	// Set up a new canvas rect, which is inset slightly from the (newly scaled) map frame. We use this during drawing to actually truly scale our GeoCoordinates to fit.
	CGRect newCanvasRect = CGRectInset(mMapView.frame, CANVAS_INSET * scale, CANVAS_INSET * scale);
	mMapView.canvasRect = newCanvasRect;

	// Set the actual scale
	mMapView.scale = scale;
	
	// And redraw.
	[mMapView setNeedsDisplay];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[mFestivalGrounds autorelease];
    [super dealloc];
}

-(void)objectClicked:(MapObject*)object
{
	if (mLabel)
	{
		[mLabel removeFromSuperview];
		[mLabel autorelease];
		mLabel = nil;
	}
	CGRect f = object.frame;
	mLabel = [[MapLabelView alloc] initWithFrame:CGRectMake(MAX(2.0, f.origin.x - 20), f.origin.y - 34, 300, 28) andObject:[object modelObject]];
	[mMapView addSubview:mLabel];
	[mLabel setClickTarget:self andSelector:@selector(mapClickInfoForObject:)];
}

-(void)mapClickInfoForObject:(LocatableModelObject*)obj;
{
	// Right now, feign calling up a detail page for the info object.
	BeerController *anotherViewController = [[BeerController alloc] initWithNibName:@"BeerController" bundle:nil];
	[anotherViewController setBeerNum:666];
	[self.navigationController pushViewController:anotherViewController animated:YES];
	[anotherViewController release];	
}


@end
