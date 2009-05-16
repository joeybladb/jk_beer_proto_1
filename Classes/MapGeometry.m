//
//  MapGeometry.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/28/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "MapGeometry.h"
#import "ngiutm.h"

UTMPoint ConvertGeoToUTMPoint(GeoPoint p)
{
	UTMPoint u;
	if (ngi_convert_geodetic_to_utm(p.y, p.x, &u.nZ, &u.eZ, &u.n, &u.e))
		NSLog(@"*** err: geo to utm conversion!");
	return u;
}

GeoPoint ConvertUTMToGeoPoint(UTMPoint u)
{
	GeoPoint p;
	if (ngi_convert_utm_to_geodetic(u.nZ, u.eZ, u.n, u.e, &p.y, &p.x))
		NSLog(@"*** err: utm to geo conversion!");
	return p;
}



NSData* CGPointToNSData(CGPoint p)
{
	CGPoint local = p;
	return [NSData dataWithBytes:&local length:sizeof(local)];
}

CGPoint NSDataToCGPoint(NSData* d)
{
	//	CGPoint p = CGPointFromString((NSString*) d);
	//	return p;
	CGPoint p;
	[d getBytes:&p length:sizeof(CGPoint)];
	return p;
}

@implementation NSDictionary (GeoPoint)
+(NSDictionary*)dictionaryWithGeoPoint:(GeoPoint)p
{
	return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:p.x], @"x", [NSNumber numberWithDouble:p.y], @"y", nil];
}

-(GeoPoint)geoPoint
{
	return GPMAKE([[self objectForKey:@"x"] doubleValue], [[self objectForKey:@"y"] doubleValue]);
}
@end
