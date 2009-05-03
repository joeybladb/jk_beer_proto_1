//
//  LocatableModelObject.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/4/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "LocatableModelObject.h"


@implementation LocatableModelObject

@synthesize name=mName;

-(id)initWithAttributes:(NSDictionary*)attrs	// In the future, we'll get some kind of JSON document, and we'll parse out a sub-section into a dictionary which inits the object.
{
	self = [super init];
	if (self)
	{
		mName = nil;
		mShape = nil;
 		mInteractsWithUser = NO;
	}
	return self;
}

-(id)initWithShapeDatabase:(Shape*)shape interactingWithUser:(BOOL)interacting named:(NSString*)name
{
	self = [super init];
	if (self)
	{
		mName = [name retain];
		mShape = [shape retain];
		mInteractsWithUser = interacting;
	}
	return self;
}

-(void)dealloc
{
	[mName autorelease];
	[mShape autorelease];
	[super dealloc];
}


//
// Getters
//
-(Shape*)shape	// May be NULL
{
	return mShape;
}

-(BOOL)interactsWithUser
{
	return mInteractsWithUser;
}


-(NSString*)briefDescription
{
	return [NSString stringWithFormat:@"I'm %@", mName];
}

@end
