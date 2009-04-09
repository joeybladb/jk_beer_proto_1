//
//  FestivalDatabase.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/4/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "FestivalDatabase.h"
#import "LocatableModelObject.h"

FestivalDatabase* sDatabase = nil;

@implementation FestivalDatabase
+(FestivalDatabase*)sharedDatabase
{
	return sDatabase;
}

-(id)initWithURL:(NSURL*)url	// Will init itself from the net. 
{
	NSAssert(sDatabase == nil, @"*** sharedFestivalDatabase inited twice.");
	self = [super init];
	if (self)
	{
		NSMutableArray* a = [NSMutableArray arrayWithCapacity:100];
		[a addObject:[[LocatableModelObject alloc] initWithImageName:@"restrooms.gif" atLocation:CGPointMake(50, 30) interactingWithUser:YES]];
		[a addObject:[[LocatableModelObject alloc] initWithImageName:@"info.gif" atLocation:CGPointMake(300, 200) interactingWithUser:YES]];
		[a addObject:[[LocatableModelObject alloc] initWithImageName:@"smoking.gif" atLocation:CGPointMake(80, 300) interactingWithUser:YES]];
		[a addObject:[[LocatableModelObject alloc] initWithImageName:@"trash.gif" atLocation:CGPointMake(450, 800) interactingWithUser:YES]];
		[a addObject:[[LocatableModelObject alloc] initWithImageName:@"restrooms.gif" atLocation:CGPointMake(10, 940) interactingWithUser:YES]];
//		[a addObject:[[LocatableModelObject alloc] initWithImageName:@"hops.png" atLocation:CGPointMake(10, 200) interactingWithUser:YES]];
		[a addObject:[[LocatableModelObject alloc] initWithImageName:@"beer28.jpeg" atLocation:CGPointMake(100, 150) interactingWithUser:YES]];
		[a addObject:[[LocatableModelObject alloc] initWithImageName:@"beer28.jpeg" atLocation:CGPointMake(100, 800) interactingWithUser:YES]];
		[a addObject:[[LocatableModelObject alloc] initWithImageName:@"beer28.jpeg" atLocation:CGPointMake(200, 150) interactingWithUser:YES]];
		[a addObject:[[LocatableModelObject alloc] initWithImageName:@"beer28.jpeg" atLocation:CGPointMake(100, 800) interactingWithUser:YES]];
		[a addObject:[[LocatableModelObject alloc] initWithImageName:@"beer28.jpeg" atLocation:CGPointMake(200, 500) interactingWithUser:YES]];
		[a addObject:[[LocatableModelObject alloc] initWithImageName:@"beer28.jpeg" atLocation:CGPointMake(100, 600) interactingWithUser:YES]];

		mLocatables = [a retain];
		sDatabase = self;
	}
	return self;
}

-(void)cacheContents			// Write contents of database to the cache file.
{
}


-(void)dealloc
{
	[mLocatables autorelease];
	mLocatables = nil;
	sDatabase = nil;
	[super dealloc];
}

-(NSArray*) locatables	// Return an array of LocatableModelObject.
{
	return mLocatables;
}

-(NSArray*) beers	// Return array of beer objects.
{
	return nil;
}

-(NSArray*) taps	// An array of dispensing stations. 1:1 with beers.
{
	return nil;
}

@end
