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


-(Shape*)buildFestivalGrounds
{
	// Create the festival grounds shape. This will eventually be got from the server
	Shape* shape = [[Shape alloc] init];
	
	// Starting at Morrison Bridge and Naito Parkway, go north:
	NSDictionary* d = [NSDictionary dictionaryWithObjectsAndKeys:
					   [NSNumber numberWithInt:ShapeMoveTo], OPKEY_OP,
					   GPMAKE_D(-122.67171800, 45.518568), OPKEY_COORD, nil];
	[shape addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.671246, 45.519588), OPKEY_COORD, nil];
	[shape addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670860, 45.520295), OPKEY_COORD, nil];
	[shape addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670696, 45.520528), OPKEY_COORD, nil];
	[shape addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670189, 45.521593), OPKEY_COORD, nil];
	[shape addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670085, 45.521964), OPKEY_COORD, nil];
	[shape addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.669523, 45.521896), OPKEY_COORD, nil];
	[shape addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.669584, 45.521558), OPKEY_COORD, nil];
	[shape addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670063, 45.520303), OPKEY_COORD, nil];
	[shape addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670522, 45.519582), OPKEY_COORD, nil];
	[shape addOp:d];
	
	// The Morrison bridge and Willamette
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.671180, 45.518374), OPKEY_COORD, nil];
	[shape addOp:d];
	
	// Finally back to Morrison and Naito.
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.671718, 45.518568), OPKEY_COORD, nil];
	[shape addOp:d];
	
	UIColor* strokeColor = [UIColor colorWithRed:.23 green:.37 blue:.4 alpha:1.0], *fillColor = [UIColor colorWithRed:0.70 green:0.89 blue:0.70 alpha:0.8];
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeFillThenStroke], OPKEY_OP,
		 fillColor, OPKEY_FILL_COLOR,
		 strokeColor, OPKEY_STROKE_COLOR, 
		 [NSNumber numberWithFloat:1.0], OPKEY_LINE_WIDTH,
		 [NSNumber numberWithInt:kCGLineCapRound], OPKEY_LINE_CAP_STYLE, nil];
	[shape addOp:d];
		
	return shape;
}


-(id)initWithURL:(NSURL*)url	// Will init itself from the net. 
{
	NSAssert(sDatabase == nil, @"*** sharedFestivalDatabase inited twice.");
	self = [super init];
	if (self)
	{
		NSMutableArray* a = [NSMutableArray arrayWithCapacity:100];
		Shape* s = nil;
		NSDictionary* d = nil;
				
		s = [self buildFestivalGrounds];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Background"] autorelease]];

		s = [[[Shape alloc] init] autorelease];
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeSign], OPKEY_OP,
			 GPMAKE_D(-122.670554, 45.520660), OPKEY_COORD, 
			 [NSNumber numberWithInt:SignFirstAid], OPKEY_SIGN, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:YES named:@"First Aid"] autorelease]];

		s = [[[Shape alloc] init] autorelease];
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeRect], OPKEY_OP,
			 GPMAKE_D(-122.670863, 45.519514), OPKEY_COORD,
			 [NSNumber numberWithFloat:18], OPKEY_WIDTH_UTM,
			 [NSNumber numberWithFloat:60], OPKEY_HEIGHT_UTM,
			 [NSNumber numberWithFloat:27.0], OPKEY_ROTATION_DEG,
			 [UIColor colorWithRed:.9 green:0.9 blue:.99 alpha:.8], OPKEY_FILL_COLOR,
			 [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8], OPKEY_STROKE_COLOR,
			 nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"South Tent"] autorelease]];

		s = [[[Shape alloc] init] autorelease];
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeRect], OPKEY_OP,
			 GPMAKE_D(-122.669973, 45.521288), OPKEY_COORD,
			 [NSNumber numberWithFloat:18], OPKEY_WIDTH_UTM,
			 [NSNumber numberWithFloat:60], OPKEY_HEIGHT_UTM,
			 [NSNumber numberWithFloat:24.0], OPKEY_ROTATION_DEG,
			 [UIColor colorWithRed:.9 green:0.9 blue:.99 alpha:.8], OPKEY_FILL_COLOR,
			 [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8], OPKEY_STROKE_COLOR,
			 nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"North Tent"] autorelease]];

		// Add trees
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
			 GPMAKE_D(-122.671128, 45.518493), OPKEY_COORD, 
			 [NSNumber numberWithInt:TreeSmall], OPKEY_TREE, nil];
		[s addOp:d];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 01"] autorelease]];
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
			 GPMAKE_D(-122.671061, 45.518619), OPKEY_COORD, 
			 [NSNumber numberWithInt:TreeSmall], OPKEY_TREE, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 02"] autorelease]];
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
			 GPMAKE_D(-122.670913, 45.518844), OPKEY_COORD, 
			 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 03"] autorelease]];
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
			 GPMAKE_D(-122.670796, 45.519089), OPKEY_COORD, 
			 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 04"] autorelease]];
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
			 GPMAKE_D(-122.670628, 45.519348), OPKEY_COORD, 
			 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 05"] autorelease]];
		/////
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
			 GPMAKE_D(-122.670479, 45.519598), OPKEY_COORD, 
			 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 06"] autorelease]];
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
			 GPMAKE_D(-122.670347, 45.519820), OPKEY_COORD, 
			 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 07"] autorelease]];
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
			 GPMAKE_D(-122.670213, 45.520109), OPKEY_COORD, 
			 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 08"] autorelease]];
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
			 GPMAKE_D(-122.670072, 45.520362), OPKEY_COORD, 
			 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 09"] autorelease]];
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
			 GPMAKE_D(-122.669940, 45.520633), OPKEY_COORD, 
			 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 10"] autorelease]];
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
			 GPMAKE_D(-122.669848, 45.520883), OPKEY_COORD, 
			 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 11"] autorelease]];
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
			 GPMAKE_D(-122.669782, 45.521153), OPKEY_COORD, 
			 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 12"] autorelease]];
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
			 GPMAKE_D(-122.669697, 45.521411), OPKEY_COORD, 
			 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 13"] autorelease]];
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
			 GPMAKE_D(-122.669634, 45.521700), OPKEY_COORD, 
			 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 14"] autorelease]];
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
			 GPMAKE_D(-122.669604, 45.521938), OPKEY_COORD, 
			 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 15"] autorelease]];
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeSign], OPKEY_OP,
			 GPMAKE_D(-122.671290, 45.518659), OPKEY_COORD, 
			 [NSNumber numberWithInt:SignRestrooms], OPKEY_SIGN, nil];
		[s addOp:d];
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 16"] autorelease]];
		
		s = [[[Shape alloc] init] autorelease];		
		d = [NSDictionary dictionaryWithObjectsAndKeys:
			 [NSNumber numberWithInt:ShapeSign], OPKEY_OP,
			 GPMAKE_D(-122.669859, 45.521734), OPKEY_COORD, 
			 [NSNumber numberWithInt:SignRestrooms], OPKEY_SIGN, nil];
		[s addOp:d];		
		[a addObject:[[[LocatableModelObject alloc] initWithShapeDatabase:s interactingWithUser:NO named:@"Tree 17"] autorelease]];
		
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
