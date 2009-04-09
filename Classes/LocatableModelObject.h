//
//  LocatableModelObject.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/4/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"

@interface LocatableModelObject : NSObject {
	NSString* mImageName;
	CGPoint	mImageLocation;
	Shape* mShape;
	BOOL mInteractsWithUser;
}

-(id)initWithAttributes:(NSDictionary*)attrs;	// In the future, we'll get some kind of JSON document, and we'll parse out a sub-section into a dictionary which inits the object.
-(id)initWithImageName:(NSString*)name atLocation:(CGPoint)point interactingWithUser:(BOOL)interacting;
-(id)initWithShapeDatabase:(Shape*)shape interactingWithUser:(BOOL)interacting;

//
// Getters
//
@property (readonly) Shape* shape;
@property (readonly) NSString* imageName;
@property (readonly) CGPoint imageLocation;

-(NSString*)briefDescription;

-(BOOL)interactsWithUser;

@end
