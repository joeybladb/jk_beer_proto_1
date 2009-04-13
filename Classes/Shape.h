//
//  Shape.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/4/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

//
// Shape is a collection of draw operations, typically expressed as geographical coordinates.
//

// Operations that a shape can peform. Right now we assume that all coordinates are absolute, but I might make a shape that's relative, so it can work like a cookie cutter.
typedef enum
{
	ShapeMoveTo,
	ShapeLineTo,
	ShapeStroke,
	ShapeFill,
	ShapeFillThenStroke,
	ShapeSign,
	ShapeTree,
} ShapeOp;

typedef enum
{
	SignCoffee,
	SignDrinkingFountain,
	SignExit,
	SignFirstAid,
	SignFood,
	SignShops,
	SignInfo,
	SignLostAndFound,
	SignMail,
	SignMensRoom,
	SignParking,
	SignRailTransit,
	SignRestrooms,		// SECOND MOST IMPORTANT
	SignSmoking,
	SignTelephone,
	SignTokens,
	SignGroundTransit,
	SignTrash,
	SignWomensRoom,
	SignMugWashStation,
	SignBeer			// MOST IMPORTANT
} ShapeSignType;	// These are some DOT approved signs

typedef enum
{
	TreeSmall,
	TreeMedium,
	TreeLarge
} TreeType;

// Build up a shape by adding dictionaries which concist of the following keys:
#define OPKEY_OP @"OP"				// NSNumber int ShapeOp
#define OPKEY_COORD @"PT"			// MoveTo/LineTo: GeoPoint;
#define OPKEY_COORD1 @"PT1"			// CGPoint as string
#define OPKEY_COORD2 @"PT2"			// CGPoint as string
#define OPKEY_FILL_COLOR @"FC"		// Fill: UIColor
#define OPKEY_STROKE_COLOR @"LC"	// Stroke: UIColor
#define OPKEY_RECT @"RECT"			// CGRect as string
#define OPKEY_LINE_WIDTH @"LW"		// Stroke: NSNumber float
#define OPKEY_LINE_CAP_STYLE @"CS"	// Stroke: NSNumber int CGLineCap
#define OPKEY_LINE_JOIN_STYLE @"JS"	// Stroke: NSNumber int CGLineJoin
#define OPKEY_SIGN @"SIGN"			// Sign: NSNumber int ShapeSignType. Will be centered around point specified by OPKEY_COORD.
#define OPKEY_TREE @"TR"			// Tree Type: NSNumber int TreeType. Centered on OPKEY_COORD.

NSData* CGPointToNSData(CGPoint p);
CGPoint NSDataToCGPoint(NSData* d);


@interface Shape : NSObject {
	NSArray* mOps;	// a series of in-order operations to be performed. these are represented by dictionaries describing the operations.
}

+(UIImage*) imageForSign:(ShapeSignType)sign;
+(void)clearCachedData;

-(void)addOp:(NSDictionary*) dict;

-(CGRect) enclosingRectangleShouldFlip:(BOOL)flip rotatingByAngle:(double)angle;	// Calculate a rectangle big enough to hold all the bits of the shape. Flip will flip the rectangle, say if we know the points are geographical coordinates.
-(CGRect) enclosingViewRectangeForCanvasRect:(CGRect)canvas;	// Given a canvas rect in view coordinates, return the shape's enclosing  rectangle, also in view coordinates. Canvas = the portion we wish to map.

-(void)renderInContext:(CGContextRef)ctx withViewFrame:(CGRect)frame andScale:(CGFloat)scale;

@end


typedef struct {double x,y;} GeoPoint;


@interface NSData (GeoPoint)
+(NSData*)dataWithGeoPoint:(GeoPoint)p;
-(GeoPoint)geoPoint;
@end

NS_INLINE GeoPoint GPMAKE(double x, double y) { GeoPoint p; p.x=x; p.y=y; return p;}				// Make a static GeoPoint.
NS_INLINE NSData* GPMAKE_D(double x, double y) { return [NSData dataWithGeoPoint:GPMAKE(x,y)]; }	// Make an NSData containing a GeoPoint -- for storing in arrays, dictionaries etc.
