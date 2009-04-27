//
//  LocatableObjectView.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/4/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shape.h"

@class LocatableModelObject;	// Some kind of data model object which might like to be reflected as an object on a map.
@class MapView;					// Some kind of Map.


// LocatableObjectView is a subview of the MapView. It refers to an object which also exists in the model.
// For right now, the view will talk directly to the model. This will probably change.

@interface LocatableObjectView : UIView {
	LocatableModelObject*	mModelObject;	// The object in the model.
	UIImage*				mCachedImage;
}

@property(nonatomic,readonly,retain) LocatableModelObject* modelObject;

-(id)intiWithObject:(LocatableModelObject*)object forMapView:(MapView*)map;	// Call this to create our state based on the object, and inserted into the map.
-(void)resizeTo:(SMapCanvasGeometryDescriptor)geometry withScale:(CGFloat)scale;	// This is called whenever we get re-scaled, i.e. via our UIScrollView.
@end
