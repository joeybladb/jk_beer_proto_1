//
//  MapController.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 3/29/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shape.h"
#import <CoreLocation/CoreLocation.h>

@class LocatableObjectView;
@class MapView;
@class MapLabelView;
@class LocatableModelObject;

@interface MapController : UIViewController <UIScrollViewDelegate,CLLocationManagerDelegate> {
	IBOutlet MapView* mMapView;
	IBOutlet UIScrollView* mScroller;
	MapLabelView* mLabel;
	Shape* mFestivalGrounds;
	SMapCanvasGeometryDescriptor mGeometry;
	UIView* mMyLocationView;
	CLLocationManager* mLocator;
}

+(MapController*)activeMapController;
@property SMapCanvasGeometryDescriptor geometry;

-(void)objectClicked:(LocatableModelObject*)locatable;

@end

@interface MapController (FestivalGrounds)
-(void)initFestivalGrounds;
@end

