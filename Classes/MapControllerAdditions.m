//
//  MapControllerAdditions.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/12/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "MapController.h"
#import "Shape.h"

@implementation MapController (FestivalGrounds)

-(void)initFestivalGrounds
{
	NSAssert(NO, @"*** Don't Call Me, Bro!");
	// Build the festival grounds shape by hand. In the future, this will be read in from a url, and stored in the FestivalDatabase.
	mFestivalGrounds = [[Shape alloc] init];
	
	// Starting at Morrison Bridge and Naito Parkway, go north:
	NSDictionary* d = [NSDictionary dictionaryWithObjectsAndKeys:
					   [NSNumber numberWithInt:ShapeMoveTo], OPKEY_OP,
					   GPMAKE_D(-122.67171800, 45.518568), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.671246, 45.519588), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670860, 45.520295), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670696, 45.520528), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670189, 45.521593), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670085, 45.521964), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	//	d = [NSDictionary dictionaryWithObjectsAndKeys:
	//		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
	//		 GPMAKE_D(-122.670098, 45.522359), OPKEY_COORD, nil];
	//	[mFestivalGrounds addOp:d];
	
	//	// Burnside bridge
	//	d = [NSDictionary dictionaryWithObjectsAndKeys:
	//		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
	//		 GPMAKE_D(-122.670206, 45.522957), OPKEY_COORD, nil];
	//	[mFestivalGrounds addOp:d];
	//
	//	// From Burnside bridge and the Wilamette, head south
	//	d = [NSDictionary dictionaryWithObjectsAndKeys:
	//		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
	//		 GPMAKE_D(-122.669448, 45.522961), OPKEY_COORD, nil];
	//	[mFestivalGrounds addOp:d];
	
	//	d = [NSDictionary dictionaryWithObjectsAndKeys:
	//		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
	//		 GPMAKE_D(-122.669447, 45.522370), OPKEY_COORD, nil];
	//	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.669523, 45.521896), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.669584, 45.521558), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670063, 45.520303), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.670522, 45.519582), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	// The Morrison bridge and Willamette
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.671180, 45.518374), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	// Finally back to Morrison and Naito.
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeLineTo], OPKEY_OP,
		 GPMAKE_D(-122.671718, 45.518568), OPKEY_COORD, nil];
	[mFestivalGrounds addOp:d];
	
	UIColor* strokeColor = [UIColor colorWithRed:.23 green:.37 blue:.4 alpha:1.0], *fillColor = [UIColor colorWithRed:0.70 green:0.89 blue:0.70 alpha:0.8];
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeFillThenStroke], OPKEY_OP,
		 fillColor, OPKEY_FILL_COLOR,
		 strokeColor, OPKEY_STROKE_COLOR, 
		 [NSNumber numberWithFloat:1.0], OPKEY_LINE_WIDTH,
		 [NSNumber numberWithInt:kCGLineCapRound], OPKEY_LINE_CAP_STYLE, nil];
	[mFestivalGrounds addOp:d];
	
	// Add trees
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.671128, 45.518493), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeSmall], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.671061, 45.518619), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeSmall], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.670913, 45.518844), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.670796, 45.519089), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.670628, 45.519348), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	/////
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.670479, 45.519598), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.670347, 45.519820), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.670213, 45.520109), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.670072, 45.520362), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.669940, 45.520633), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.669848, 45.520883), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.669782, 45.521153), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.669697, 45.521411), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.669634, 45.521700), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeTree], OPKEY_OP,
		 GPMAKE_D(-122.669604, 45.521938), OPKEY_COORD, 
		 [NSNumber numberWithInt:TreeMedium], OPKEY_TREE, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeSign], OPKEY_OP,
		 GPMAKE_D(-122.671290, 45.518659), OPKEY_COORD, 
		 [NSNumber numberWithInt:SignRestrooms], OPKEY_SIGN, nil];
	[mFestivalGrounds addOp:d];
	
	d = [NSDictionary dictionaryWithObjectsAndKeys:
		 [NSNumber numberWithInt:ShapeSign], OPKEY_OP,
		 GPMAKE_D(-122.669859, 45.521734), OPKEY_COORD, 
		 [NSNumber numberWithInt:SignRestrooms], OPKEY_SIGN, nil];
	[mFestivalGrounds addOp:d];

}
@end
