//
//  LocatableModelObject.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/4/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "LocatableModelObject.h"


@implementation LocatableModelObject

-(id)initWithAttributes:(NSDictionary*)attrs	// In the future, we'll get some kind of JSON document, and we'll parse out a sub-section into a dictionary which inits the object.
{
	self = [super init];
	if (self)
	{
		mImageName = nil;
		mShape = nil;
 		mInteractsWithUser = NO;
	}
	return self;
}

-(id)initWithImageName:(NSString*)name atLocation:(CGPoint)point interactingWithUser:(BOOL)interacting
{
	self = [super init];
	if (self)
	{
		mImageName = [name retain];
		mImageLocation = point;
		mShape = nil;
		mInteractsWithUser = interacting;
	}
	return self;
}

-(id)initWithShapeDatabase:(Shape*)shape interactingWithUser:(BOOL)interacting
{
	self = [super init];
	if (self)
	{
		mImageName = nil;
		mShape = [shape retain];
		mInteractsWithUser = interacting;
	}
	return self;
}

-(void)dealloc
{
	[mImageName autorelease];
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

-(NSString*) imageName
{
	return mImageName;
}

-(CGPoint) imageLocation
{
	return mImageLocation;
}

-(BOOL)interactsWithUser
{
	return mInteractsWithUser;
}


-(NSString*)briefDescription
{
	return @"I'm an object on the map.";
}

@end
