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
	Shape* mBackgroundShape;
	CGRect mCanvasRect;
	CGFloat mScale;
}

@property CGRect canvasRect;
@property CGFloat scale;

- (id)initWithFrame:(CGRect)frame andCanvasRect:(CGRect)canvas;

-(MapController*)controller;
-(void)setController:(MapController*)controller;

-(void)setBackgroundShape:(Shape*)s;

-(void)setTransformWithoutScaling:(CGAffineTransform)newTransform;

@end
