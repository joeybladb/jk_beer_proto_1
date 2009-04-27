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

typedef struct {double x,y;} GeoPoint;
typedef struct {double e, n; char nZ; long eZ; } UTMPoint;

//
// Convert between geo and utm points. Assumes WGS-84 datum.
//
UTMPoint ConvertGeoToUTMPoint(GeoPoint p);
GeoPoint ConvertUTMToGeoPoint(UTMPoint u);


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
	ShapeRect,
	ShapeCircle,
	ShapeArc,
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
#define OPKEY_COORD @"PT"			// MoveTo/LineTo/Circle/Arc/Rect: GeoPoint;
#define OPKEY_COORD_UTM @"PTU"		// LineTo:  GeoPoint, meters, relative to first MoveTo point.
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

#define OPKEY_ROTATION_DEG @"ROT"	// Rect (et al): NSNumber angle degrees to draw shape.

#define OPKEY_SIZE @"SZ"			// Circle/Arc: radius in delta decimal degrees 
#define OPKEY_SIZE_UTM	@"SZU"		// Circle/Arc: radius in meters.
#define OPKEY_START_ANGLE @"START"	// Arc: start angle degrees, NSNumber float.
#define OPKEY_STOP_ANGLE @"STOP"	// Arc: end angle degrees, NSNumber float.
#define OPLEY_CLOCKWISE @"CLK"		// Arc: draw arc clockwise. NSNumber BOOL.

#define OPKEY_WIDTH	@"WD"			// Rect: Width in delta decimal degrees
#define OPKEY_HEIGHT @"HT"			// Rect: Height in delta decimal degrees
#define OPKEY_WIDTH_UTM @"WDU"		// Rect: Width in meters
#define OPKEY_HEIGHT_UTM @"HTU"		// Rect: Height in meters.

NSData* CGPointToNSData(CGPoint p);
CGPoint NSDataToCGPoint(NSData* d);

// SMapCanvasGeometryDescriptor describes the mapping between geo and view coordinates. I'm letting Shape objects dictate their size and position.
typedef struct 
{
	CGRect geoBounds;		// Bounds given in terms of decimal degrees origin (long,lat), size is decimal degrees delta (longD, latD). Cocoa "unflipped", where origin is (left,bottom).
	CGRect viewFrame;		// Bounds of the entire view. This is a zero origin rectangle. It will be used to describe the frame of the MapView.
	CGRect canvasRect;		// Bounds in view coordinates, maps to geoBounds proportionally. Flipped such that origin is (left,top)
	CGRect localViewFrame;	// Frame of a view whose frame is expressed relative to viewFrame/canvasRect as bounds. This gets set before every instance of drawing, and is not global.
	float rotationDegrees;	// A rotation in degrees.
}
SMapCanvasGeometryDescriptor;

@class FestivalDatabase;

@interface Shape : NSObject {
	NSArray* mOps;	// a series of in-order operations to be performed. these are represented by dictionaries describing the operations.
}

+(UIImage*) imageForSign:(ShapeSignType)sign;
+(void)clearCachedData;

+(SMapCanvasGeometryDescriptor) geoDescriptorForFestival:(FestivalDatabase*)db constrainedToWidth:(CGFloat)width insettingViewBy:(CGFloat)inset rotatingByAngle:(CGFloat)degrees;

-(void)addOp:(NSDictionary*) dict;

-(CGRect) enclosingGeoRectangle;	// Return a rectangle in absolute Geo coordinates, describing the extent of the receiver.
-(CGRect) enclosingViewRectangeForGeometry:(SMapCanvasGeometryDescriptor)geometry;	// Given a canvas rect in view coordinates, return the shape's enclosing  rectangle, also in view coordinates. Canvas = the portion we wish to map.

-(void)renderInContext:(CGContextRef)ctx withGeometry:(SMapCanvasGeometryDescriptor)geometry andScale:(CGFloat)scale;

-(CGPoint)convertToViewCoordinate:(GeoPoint)geoPoint usingGeometry:(SMapCanvasGeometryDescriptor)geometry;
-(GeoPoint)convertToGeoCoordinate:(CGPoint)point usingGeometry:(SMapCanvasGeometryDescriptor)geometry;

@end

@interface NSData (GeoPoint)
+(NSData*)dataWithGeoPoint:(GeoPoint)p;
-(GeoPoint)geoPoint;
@end

NS_INLINE GeoPoint GPMAKE(double x, double y) { GeoPoint p; p.x=x; p.y=y; return p;}				// Make a static GeoPoint.
NS_INLINE NSData* GPMAKE_D(double x, double y) { return [NSData dataWithGeoPoint:GPMAKE(x,y)]; }	// Make an NSData containing a GeoPoint -- for storing in arrays, dictionaries etc.
NS_INLINE double DegreesToRadians(double degrees)
{
	const double conversion = 3.1415926535 / 180.0;
	return degrees * conversion;
}

