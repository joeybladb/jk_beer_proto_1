//
//  LatLongViewController.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 5/2/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

// this controls a view which displays the lat / long, and hopefully hdop or accuracy or whatever.

extern float gCurLatCenter, gCurLongCenter;	// these will contain the results (at exit) of our current lat long.

// These are offsets used for demo purposes only.
extern double gLat, gLong, gAcc;

@interface LatLongViewController : UIViewController <CLLocationManagerDelegate> {
	IBOutlet UILabel* mLatText;
	IBOutlet UILabel* mLongText;
	IBOutlet UILabel* mAccText;
	CLLocationManager* mLocator;
}

-(IBAction)onButtonClick:(id)sender;	// Means advance to the map page.
-(IBAction)onIgnoreClick:(id)sender;
@end
