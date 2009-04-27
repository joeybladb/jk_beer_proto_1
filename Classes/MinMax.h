//
//  MinMax.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/25/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "Shape.h"

// Move all my min-max, rectangle calculation stuff out of Shape and into a centralized place where
// I can use it again and again, rather than re-write it every other hour.

typedef struct 
{
	double minX, minY, maxX, maxY;
} MinMax;

NS_INLINE MinMax MinMaxInit()
{
	MinMax mm;
	mm.minX = 1.0e+12;
	mm.minY = 1.0e+12;
	mm.maxX = -1.0e+12;
	mm.maxY = -1.0e+12;
	return mm;
}

NS_INLINE MinMax MinMaxForGeoPoint(MinMax in, GeoPoint p)
{
	in.minX = MIN(in.minX, p.x);
	in.minY = MIN(in.minY, p.y);
	in.maxX = MAX(in.maxX, p.x);
	in.maxY = MAX(in.maxY, p.y);
	return in;
}

NS_INLINE MinMax MinMaxForCGRect(MinMax in, CGRect r)
{
	in.minX = MIN(in.minX, r.origin.x);
	in.minY = MIN(in.minY, r.origin.y);
	in.maxX = MAX(in.maxX, r.origin.x);
	in.maxY = MAX(in.maxY, r.origin.y);

	in.minX = MIN(in.minX, r.origin.x + r.size.width);
	in.minY = MIN(in.minY, r.origin.y + r.size.height);
	in.maxX = MAX(in.maxX, r.origin.x + r.size.width);
	in.maxY = MAX(in.maxY, r.origin.y + r.size.height);
	return in;
}


NS_INLINE MinMax MinMaxForCGPoint(MinMax in, CGPoint p)
{
	in.minX = MIN(in.minX, p.x);
	in.minY = MIN(in.minY, p.y);
	in.maxX = MAX(in.maxX, p.x);
	in.maxY = MAX(in.maxY, p.y);
	return in;
}

NS_INLINE CGRect CGRectFromMinMax(MinMax in)
{
	return CGRectMake(in.minX, in.minY, in.maxX - in.minX, in.maxY - in.minY);
}
