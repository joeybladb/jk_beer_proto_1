//
//  MapController.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 3/29/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "MapController.h"


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
	NSLog(@"*** mapFrame = %@", NSStringFromRect(NSRectFromCGRect(mMapView.frame)));
	
	UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map.png"]];
	mMapView = tempImageView;	
	mScroller.contentSize = CGSizeMake(mMapView.frame.size.width, mMapView.frame.size.height);
	mScroller.maximumZoomScale = 4.0;
	mScroller.minimumZoomScale = 0.75;
	mScroller.clipsToBounds = YES;
	mScroller.delegate = self;
    [mScroller addSubview:mMapView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	NSLog(@"### scroll bounds = %@", NSStringFromRect(NSRectFromCGRect(mScroller.bounds)));
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView     // return a view that will be scaled. if delegate returns nil, nothing happens
{
	return mMapView;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale // scale between minimum and maximum. called after any 'bounce' animations
{
	NSLog(@"-scrollViewDidEndZooming new scale = %0.3f", scale);
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
    [super dealloc];
}


@end
