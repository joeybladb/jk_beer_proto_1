//
//  LatLongViewController.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 5/2/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "LatLongViewController.h"
#import "MapController.h"

double gLat = 0.0, gLong = 0.0, gAcc = 0.0;

@implementation LatLongViewController

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


/*
 *  locationManager:didUpdateToLocation:fromLocation:
 *  
 *  Discussion:
 *    Invoked when a new location is available. oldLocation may be nil if there is no previous location
 *    available.
 */
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
	gLat = newLocation.coordinate.latitude;
	gLong = newLocation.coordinate.longitude;
	gAcc = newLocation.horizontalAccuracy;
	mLatText.text = [NSString stringWithFormat:@"%0.6f°", gLat];
	mLongText.text = [NSString stringWithFormat:@"%0.6f°", gLong];
	mAccText.text = [NSString stringWithFormat:@"%0.6f°", gAcc];

	[self.view setNeedsDisplay];
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
	NSLog(@"Awww shit! Fuck! Location Manager error: %@", error);
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	mLocator = [[CLLocationManager alloc] init];
	mLocator.delegate = self;
	gLat = 0.0;
	gLong = 0.0;
	gAcc = 0.0;
	[mLocator startUpdatingLocation];
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

-(IBAction)onButtonClick:(id)sender	// Means advance to the map page.
{
	MapController *anotherViewController = [[MapController alloc] initWithNibName:@"MapController" bundle:nil];
	[self.navigationController pushViewController:anotherViewController animated:YES];
	[anotherViewController release];
	[mLocator stopUpdatingLocation];
}


- (void)dealloc {
    [super dealloc];
}


@end
