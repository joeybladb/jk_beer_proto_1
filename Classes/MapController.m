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
//	NSLog(@"*** mapFrame = %@", NSStringFromRect(NSRectFromCGRect(mMapView.frame)));

	// Build the festival grounds shape by hand. In the future, this will be read in from a url, and stored in the FestivalDatabase.
	mFestivalGrounds = [[Shape alloc] init];

	// Starting at Morrison Bridge and Naito Parkway, go north:
	NSDictionary* d = [NSDictionary dictionaryWithObjectsAndKeys:
						[NSNumber numberWithInt:ShapeMoveTo], OPKEY_OP,
						GPMAKE_D(-122.67171800, 45.518568), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
			 GPMAKE_D(-122.671246, 45.519588), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];

	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670860, 45.520295), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];

	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670696, 45.520528), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];

	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670189, 45.521593), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];

	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670085, 45.521964), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
//	d = [NSDictionary dictionaryWithObjectsAndKeys:
//		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
//		 GPMAKE_D(-122.670098, 45.522359), OPKEY_COORD, nil];
//	[mFestivalGrounds addOp:d];

//	// Burnside bridge
//	d = [NSDictionary dictionaryWithObjectsAndKeys:
//		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
//		 GPMAKE_D(-122.670206, 45.522957), OPKEY_COORD, nil];
//	[mFestivalGrounds addOp:d];
//
//	// From Burnside bridge and the Wilamette, head south
//	d = [NSDictionary dictionaryWithObjectsAndKeys:
//		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
//		 GPMAKE_D(-122.669448, 45.522961), OPKEY_COORD, nil];
//	[mFestivalGrounds addOp:d];

//	d = [NSDictionary dictionaryWithObjectsAndKeys:
//		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
//		 GPMAKE_D(-122.669447, 45.522370), OPKEY_COORD, nil];
//	[mFestivalGrounds addOp:d];

	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.669523, 45.521896), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.669584, 45.521558), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670063, 45.520303), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];

	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670522, 45.519582), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	// The Morrison bridge and Willamette
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.671180, 45.518374), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];

	// Finally back to Morrison and Naito.
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.671718, 45.518568), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	UIColor* strokeColor = [UIColor colorWithRed:.23 green:.37 blue:.4 alpha:1.0], *fillColor = [UIColor colorWithRed:0.70 green:0.89 blue:0.70 alpha:0.8];
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeFillThenStroke], OPKEY_OP,
		 fillColor, OPKEY_FILL_COLOR,
		 strokeColor, OPKEY_STROKE_COLOR, 
		 [NSNumber numberWithFloat:1.0], OPKEY_LINE_WIDTH,
		 [NSNumber numberWithInt:kCGLineCapRound], OPKEY_LINE_CAP_STYLE, nil];
	[mFestivalGrounds addOp:d];
	
	// Add trees
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.671128, 45.518493), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeSmall], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];

	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.671061, 45.518619), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeSmall], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];

	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.670913, 45.518844), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];

	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.670796, 45.519089), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];

	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.670628, 45.519348), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
/////
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.670479, 45.519598), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.670347, 45.519820), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.670213, 45.520109), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.670072, 45.520362), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.669940, 45.520633), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.669848, 45.520883), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.669782, 45.521153), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.669697, 45.521411), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.669634, 45.521700), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.669604, 45.521938), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];

	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeSign], OPKEY_OP,
		 GPMAKE_D(-122.671290, 45.518659), OPKEY_COORD, 
		 [NSNumber numberWithInt:SignRestrooms], OPKEY_SIGN, nil];
	[mFestivalGrounds addOp:d];

	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeSign], OPKEY_OP,
		 GPMAKE_D(-122.669859, 45.521734), OPKEY_COORD, 
		 [NSNumber numberWithInt:SignRestrooms], OPKEY_SIGN, nil];
	[mFestivalGrounds addOp:d];
	
	
	
	CGRect bounds = [mFestivalGrounds enclosingRectangleShouldFlip:YES rotatingByAngle:(double)0.0];
	// First pass, assume y > x
	// 
#define CANVAS_INSET 10.0
#define START_WIDTH 320	
	CGRect viewRect = CGRectMake(0, 0, START_WIDTH + CANVAS_INSET * 2.0, START_WIDTH * (bounds.size.height / bounds.size.width) + CANVAS_INSET * 2.0);
	CGRect canvasRect = CGRectInset(viewRect, 10, 10);
	
	mMapView = [[MapView alloc] initWithFrame:viewRect andCanvasRect:canvasRect];	// Mapview will automatically populate itself with subviews corresponding to locatable objects in the database.
	mMapView.backgroundColor = [UIColor colorWithRed:.95 green:.95 blue:.81 alpha:1.0];
	[(MapView*)mMapView setController:self];
	[(MapView*)mMapView setBackgroundShape:mFestivalGrounds];

	mScroller.contentSize = CGSizeMake(mMapView.frame.size.width, mMapView.frame.size.height);
	mScroller.maximumZoomScale = 4.0;
	mScroller.minimumZoomScale = 0.5;
	mScroller.clipsToBounds = YES;
	mScroller.delegate = self;
    [mScroller addSubview:mMapView];
	

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
	[mMapView setNeedsDisplay];
//	CGRect f = view.frame;
	NSLog(@"-scrollViewDidEndZooming new scale = %0.3f", scale);
	NSLog(@"New bounds = %@", NSStringFromCGRect(view.bounds));
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
