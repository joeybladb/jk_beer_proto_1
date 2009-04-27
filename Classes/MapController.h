//
//  MapController.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 3/29/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shape.h"

@class LocatableObjectView;
@class MapView;
@class MapLabelView;


@interface MapController : UIViewController <UIScrollViewDelegate> {
	IBOutlet MapView* mMapView;
	IBOutlet UIScrollView* mScroller;
	MapLabelView* mLabel;
	Shape* mFestivalGrounds;
//	CGRect mOriginalMapFrame;
	SMapCanvasGeometryDescriptor mGeometry;
}

+(MapController*)activeMapController;
@property SMapCanvasGeometryDescriptor geometry;

-(void)objectClicked:(LocatableObjectView*)object;

@end

@interface MapController (FestivalGrounds)
-(void)initFestivalGrounds;
@end

