//
//  MapController.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 3/29/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "MapController.h"
#import "MapView.h"
#import "LocatableObjectView.h"
#import "MapLabelView.h"
#import "BeerController.h"
#import "Shape.h"
#import "UIColor+Components.h"
#import "LocatableModelObject.h"
#import "FestivalDatabase.h"
#import "LatLongViewController.h"
#import "MeView.h"
#import "ExpandingCircle.h"


MapController* sActiveController = nil;
SMapCanvasGeometryDescriptor sGeometry;
BOOL sGeoIsSet = NO;

@implementation MapController

@synthesize geometry=mGeometry;

+(MapController*)activeMapController
{
	return sActiveController;
}

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
- (void)viewDidLoad 
{
	sActiveController = self;
    [super viewDidLoad];

#define CANVAS_INSET 10.0
#define START_WIDTH 320
#define ROTATE_CANVAS_DEGREES -0.0

	// Build the geometry -- this specifies an extra layer of conversion that happens between geo-coordinates in the locatable model shapes and actual view coordinates.
	mGeometry = [Shape geoDescriptorForFestival:[FestivalDatabase sharedDatabase] constrainedToWidth:START_WIDTH insettingViewBy:CANVAS_INSET rotatingByAngle:ROTATE_CANVAS_DEGREES];
	
	// Build the map view:
	mMapView = [[MapView alloc] initWithGeometry:mGeometry];	// Mapview will automatically populate itself with subviews corresponding to locatable objects in the database.
	mMapView.backgroundColor = [UIColor colorWithRed:.95 green:.95 blue:.81 alpha:1.0];
	[(MapView*)mMapView setController:self];

	CGAffineTransform tx = mMapView.transform;
	mMapView.transform = tx;

	// Put the map view IN the scroller, fix up the settings on the scroller.
	mScroller.contentSize = CGSizeMake(mMapView.frame.size.width, mMapView.frame.size.height);
	mScroller.maximumZoomScale = 6.0;
	mScroller.minimumZoomScale = 0.75;
	mScroller.clipsToBounds = YES;
	mScroller.delegate = self;
    [mScroller addSubview:mMapView];
	
	mMyLocationView = nil;
	[super viewDidLoad];
	mLocator = [[CLLocationManager alloc] init];
	mLocator.delegate = self;
	[mLocator startUpdatingLocation];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
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
	mGeometry.canvasRect = newCanvasRect;
	mGeometry.viewFrame = mMapView.frame;
	mGeometry.modTime = CFAbsoluteTimeGetCurrent();

	// Set the actual scale
	mMapView.scale = scale;
	
	// Notify our subviews of the change:
//	NSEnumerator* e = [mMapView.subviews objectEnumerator];
//	UIView* v;
//	while (nil != (v = [e nextObject]))
//	{
//		if ([v respondsToSelector:@selector(resizeTo:withScale:)])
//			[(LocatableObjectView*) v resizeTo:mGeometry withScale:scale];
//	}
	
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

-(void)objectClicked:(LocatableModelObject*)locatable
{
	if (mLabel)
	{
		[mLabel removeFromSuperview];
		[mLabel autorelease];
		mLabel = nil;
	}
	
	if (locatable)
	{
#define NUB_HEIGHT 8	
#define VIEW_FROM_NIB_HEIGHT 32
#define HORIZONTAL_OFFSET 20
#define VERTICAL_OFFSET NUB_HEIGHT+VIEW_FROM_NIB_HEIGHT-4
#define HORIZONTAL_SPACING 32
		
		Shape* theShape = locatable.shape;
		CGRect locatableFrame = [theShape enclosingViewRectangeForGeometry:mGeometry];
		CGSize sz = [[locatable briefDescription] sizeWithFont:[UIFont systemFontOfSize:14]];
		CGRect labelFrame = CGRectMake(MAX(2.0, locatableFrame.origin.x - HORIZONTAL_OFFSET), locatableFrame.origin.y - VIEW_FROM_NIB_HEIGHT, sz.width + HORIZONTAL_SPACING, VIEW_FROM_NIB_HEIGHT + NUB_HEIGHT);
		
		// Make sure that labelFrame fits within the entire map's bounds. TODO It might be a good thing then to also scroll the entire label into view.
		BOOL arrowNubOnBottom = YES;	// The arrow nub is a triangle shaped thing on a label view which points at the object. It's either on the bottom or the top.
		CGRect mapFrame = mMapView.frame;
		
		// First figure out right edge:
		CGFloat mapRightEdgeExtent = mapFrame.origin.x + mapFrame.size.width, labelRightEdge = labelFrame.origin.x + labelFrame.size.width;
		if (labelRightEdge > mapRightEdgeExtent)
		{	// If the label is sticking off the right edge, then shift it to the left 
			labelFrame.origin.x -= labelRightEdge - mapRightEdgeExtent;
		}
		
		// If we're off the left edge, shift to the right.
		if (labelFrame.origin.x < mapFrame.origin.x)
			labelFrame.origin.x;
		
		// Todo: if the label width is too big, then trim it to fit.
		
		// Now make sure we haven't gone off the top:
		if (labelFrame.origin.y < mapFrame.origin.y)
		{	// Place the label UNDER the object, with the arrow nub pointing up.
			labelFrame.origin.y = locatableFrame.origin.y + locatableFrame.size.height + 16;
			arrowNubOnBottom = NO;
		}

		mLabel = [[MapLabelView alloc] initWithFrame:labelFrame andObject:locatable withBottomNub:arrowNubOnBottom andNubPosition:CGRectGetMidX(locatableFrame)];
		[mMapView addSubview:mLabel];
		[mLabel setClickTarget:self andSelector:@selector(mapClickInfoForObject:)];
	}
}

-(void)mapClickInfoForObject:(LocatableModelObject*)obj;
{
	// Right now, feign calling up a detail page for the info object.
	BeerController *anotherViewController = [[BeerController alloc] initWithNibName:@"BeerController" bundle:nil];
	[anotherViewController setBeerNum:666];
	[self.navigationController pushViewController:anotherViewController animated:YES];
	[anotherViewController release];	
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
	if (mMyLocationView	== nil)
	{
		mMyLocationView = [[MeView alloc] initWithFrame:CGRectMake(0,0,8,8)];
		[mMapView addSubview:mMyLocationView];
		NSLog(@"New Thingy!");
	}
	// Get geo point from thingy
	CGFloat xOffset = CGRectGetMidX(mGeometry.geoBounds) - gLong;
	CGFloat yOffset = CGRectGetMidY(mGeometry.geoBounds) - gLat;

	GeoPoint gp = GPMAKE(newLocation.coordinate.longitude + xOffset, newLocation.coordinate.latitude + yOffset);
	
	// Create temp shape, and convert geo to view coord:
	Shape* tempShape = [[[Shape alloc] init] autorelease];
	CGPoint theCenter = [tempShape convertToViewCoordinate:gp usingGeometry:self.geometry];
	
	// Using the horizontal accuracy, re-size the view:
	CGFloat horizAccuracy = newLocation.horizontalAccuracy / 2;
	UTMPoint utmTopLeftPt = ConvertGeoToUTMPoint(gp), utmBottomRight = utmTopLeftPt;
	utmTopLeftPt.e -= horizAccuracy;
	utmTopLeftPt.n += horizAccuracy;
	utmBottomRight.e += horizAccuracy;
	utmBottomRight.n -= horizAccuracy;
	CGPoint viewTopLeft = [tempShape convertToViewCoordinate:ConvertUTMToGeoPoint(utmTopLeftPt) usingGeometry:mGeometry];
	CGPoint viewBotRight = [tempShape convertToViewCoordinate:ConvertUTMToGeoPoint(utmBottomRight) usingGeometry:mGeometry];
	CGRect myNewFrame = mMyLocationView.frame;
	myNewFrame.size.width = viewBotRight.y - viewTopLeft.y;
	myNewFrame.size.height = viewBotRight.y - viewTopLeft.y;
	
	// Now set up the view's new center / size, w/ a linear animation.
	[UIView beginAnimations:@"MovingMe" context:self];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDuration:0.2];
	mMyLocationView.frame = myNewFrame;	// TODO: UIScrollView zooming will screw up our frame/bounds. MapController will need to fix us up. Also, it should remove all subviews views which are not in the display for better efficiency.
	mMyLocationView.center = theCenter;
	[UIView commitAnimations];
}

/*
 *  locationManager:didFailWithError:
 *  
 *  Discussion:
 *    Invoked when an error has occurred.
 */
- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	NSLog(@"Awww shit! Fuck! MapController -- Location Manager error: %@", error);
}


@end
