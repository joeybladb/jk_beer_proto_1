//
//  MapController.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 3/29/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapObject;
@class MapView;
@class MapLabelView;
@class Shape;


@interface MapController : UIViewController <UIScrollViewDelegate> {
	IBOutlet MapView* mMapView;
	IBOutlet UIScrollView* mScroller;
	MapLabelView* mLabel;
	Shape* mFestivalGrounds;
}

-(void)objectClicked:(MapObject*)object;

@end
