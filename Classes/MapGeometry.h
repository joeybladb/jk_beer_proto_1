//
//  MapGeometry.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/28/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import <Foundation/Foundation.h>


// SMapCanvasGeometryDescriptor describes the mapping between geo and view coordinates. I'm letting Shape objects dictate their size and position.
typedef struct 
{
	CGRect geoBounds;		// Bounds given in terms of decimal degrees origin (long,lat), size is decimal degrees delta (longD, latD). Cocoa "unflipped", where origin is (left,bottom)
	CGRect viewFrame;		// Bounds of the entire view. This is a zero origin rectangle. It will be used to describe the frame of the MapView.
	CGRect canvasRect;		// Bounds in view coordinates, maps to geoBounds proportionally. Flipped such that origin is (left,top)
	CGRect localViewFrame;	// Frame of a view whose frame is expressed relative to viewFrame/canvasRect as bounds. This gets set before every instance of drawing, and is not global.
	float rotationDegrees;	// A rotation in degrees.
	CGRect startViewFrame;	// This is the original view frame. We keep it around so we can scale backwards.
	NSTimeInterval modTime;	// Anytime a changeable value is modified, this should get updated. 
}
SMapCanvasGeometryDescriptor;

typedef struct {double x,y;} GeoPoint;
typedef struct {double e, n; char nZ; long eZ; } UTMPoint;

//
// Convert between geo and utm points. Assumes WGS-84 datum.
//
UTMPoint ConvertGeoToUTMPoint(GeoPoint p);
GeoPoint ConvertUTMToGeoPoint(UTMPoint u);

NSData* CGPointToNSData(CGPoint p);
CGPoint NSDataToCGPoint(NSData* d);

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


NS_INLINE GeoPoint Rotate(GeoPoint point, double angle)
{ 
	float xold,yold;
	GeoPoint newpoint;
	angle = DegreesToRadians(angle);
	xold=point.x;
	yold=point.y;
	newpoint.x= xold*cos(angle)-yold*sin(angle);
	newpoint.y= xold*sin(angle)+yold*cos(angle);
	return newpoint;
}

NS_INLINE GeoPoint TranslateAndRotate(GeoPoint point, GeoPoint anchor, double angle)
{	// Translate by anchor, rotate, and un-translate by anchor.
	GeoPoint txPt = Rotate(GPMAKE(point.x - anchor.x, point.y - anchor.y), angle);
	return GPMAKE(txPt.x + anchor.x, txPt.y + anchor.y);
}



