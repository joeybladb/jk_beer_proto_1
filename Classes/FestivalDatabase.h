//
//  FestivalDatabase.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/4/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FestivalDatabase : NSObject {
	NSArray* mLocatables;	// This is just POC stuff.
}

+(FestivalDatabase*)sharedDatabase;

-(id)initWithURL:(NSURL*)url;	// Will init itself from the net and/or a cached data file.
-(void)cacheContents;			// Write contents of database to the cache file.

-(NSArray*) locatables;	// Return an array of LocatableModelObject.
-(NSArray*) beers;	// Return array of beer objects.
-(NSArray*) taps;	// An array of dispensing stations. 1:1 with beers.
@end
