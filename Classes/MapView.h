//
//  MapView.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/2/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapController.h"
#import "Shape.h"


@interface MapView : UIView {
	MapController* mController;
	CGFloat mScale;
}

@property CGFloat scale;

- (id)initWithGeometry:(SMapCanvasGeometryDescriptor)geo;

-(MapController*)controller;
-(void)setController:(MapController*)controller;

-(void)setTransformWithoutScaling:(CGAffineTransform)newTransform;

@end
