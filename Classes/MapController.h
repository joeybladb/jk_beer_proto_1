//
//  MapController.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 3/29/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MapController : UIViewController <UIScrollViewDelegate> {
	IBOutlet UIView* mMapView;
	IBOutlet UIScrollView* mScroller;
}

@end
