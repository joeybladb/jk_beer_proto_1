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
	NSString* mName;
	Shape* mShape;
	BOOL mInteractsWithUser;
}

-(id)initWithAttributes:(NSDictionary*)attrs;	// In the future, we'll get some kind of JSON document, and we'll parse out a sub-section into a dictionary which inits the object.
-(id)initWithShapeDatabase:(Shape*)shape interactingWithUser:(BOOL)interacting named:(NSString*)name;

//
// Getters
//
@property (readonly,retain) Shape* shape;
@property (readonly,retain) NSString* name;

-(NSString*)briefDescription;

-(BOOL)interactsWithUser;

@end
