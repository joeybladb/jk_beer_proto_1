//
//  Shape.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/4/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "Shape.h"
#import "UIColor+Components.h"
#import "FestivalDatabase.h"
#import "LocatableModelObject.h"
#import "MinMax.h"
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

typedef struct  
{
	CGRect geoRect, viewRect;
} SRectPair;

NSMutableDictionary* sSignCache = nil;

@implementation Shape

-(SRectPair) _pairForRectOp:(NSDictionary*)d andGeometry:(SMapCanvasGeometryDescriptor*)geo	// Given op dictionary w/ Rect opcode and optional geo rectangle, return geo and view rectangles. if geo is nil, then view rectangle will be inoperable.
{
	SRectPair pair;
	double	width = [[d objectForKey:OPKEY_WIDTH_UTM] floatValue], 
			height = [[d objectForKey:OPKEY_HEIGHT_UTM] floatValue];

	GeoPoint geoPt = [(NSData*) [d objectForKey:OPKEY_COORD] geoPoint];
	
	UTMPoint uP = ConvertGeoToUTMPoint(geoPt);
	UTMPoint uLeftTop = uP, uRightBottom = uP;
	uLeftTop.e -= width / 2.0;
	uLeftTop.n -= height / 2.0;
	uRightBottom.e += width / 2.0;
	uRightBottom.n += height / 2.0;
	GeoPoint lt = ConvertUTMToGeoPoint(uLeftTop), rb = ConvertUTMToGeoPoint(uRightBottom);
	pair.geoRect = CGRectMake(lt.x, lt.y, rb.x-lt.x, rb.y-lt.y);
	if (geo)
	{
		CGPoint gLT = [self convertToViewCoordinate:lt usingGeometry:*geo], gRB = [self convertToViewCoordinate:rb usingGeometry:*geo];
		pair.viewRect = CGRectStandardize(CGRectMake(gLT.x, gLT.y, gRB.x - gLT.x, gRB.y - gLT.y));
	}
	else
		pair.viewRect = CGRectNull;
	return pair;
}

-(CGRect) enclosingGeoRectangle	// Return a rectangle in absolute Geo coordinates, describing the extent of the receiver.
{
	// find min and max vertices etc.
	MinMax mm = MinMaxInit();
	NSDictionary* d;
	NSEnumerator* e = [mOps objectEnumerator];
	
	while (nil != (d = [e nextObject]))
	{
		NSData* data = (NSData*) [d objectForKey:OPKEY_COORD];
		if (data)
		{
			GeoPoint p = [data geoPoint];
			mm = MinMaxForGeoPoint(mm, p);
		}
		
		ShapeOp op = (ShapeOp) [[d objectForKey:OPKEY_OP] intValue];
		if (op == ShapeRect)
		{
			SRectPair pair = [self _pairForRectOp:d andGeometry:nil];
			mm = MinMaxForCGRect(mm, pair.geoRect);
		}
	}
	return CGRectFromMinMax(mm);
}


+(UIImage*) imageForSign:(ShapeSignType)sign
{
	UIImage* result = nil;
	if (sSignCache == nil)
	{
		sSignCache = [[NSMutableDictionary dictionaryWithCapacity:25] retain];
	}
	result = [sSignCache objectForKey:[NSNumber numberWithInt:sign]];
	if (result == nil)
	{
		NSString* imageName =  nil;
		switch (sign) 
		{
			case SignCoffee:
				imageName = @"coffee.gif";
				break;
				
			case SignDrinkingFountain:
				imageName = @"drinkingfountain.gif";
				break;
				
			case SignExit:
				imageName = @"exit.gif";
				break;
				
			case SignFirstAid:
				imageName = @"firstaid.gif";
				break;
				
			case SignFood:
				imageName = @"food.gif";
				break;
				
			case SignShops:
				imageName = @"gifts.gif";
				break;
				
			case SignInfo:
				imageName = @"info.gif";
				break;
				
			case SignLostAndFound:
				imageName = @"lostandfound.gif";
				break;
				
			case SignMail:
				imageName = @"mail.gif";
				break;
				
			case SignMensRoom:
				imageName = @"mensrr.gif";
				break;
				
			case SignParking:
				imageName = @"parking.gif";
				break;
				
			case SignRailTransit:
				imageName = @"rail.gif";
				break;
				
			case SignRestrooms:
				imageName = @"restrooms.gif";
				break;
				
			case SignSmoking:
				imageName = @"smoking.gif";
				break;
				
			case SignTelephone:
				imageName = @"telephone.gif";
				break;
				
			case SignTokens:
				imageName = @"tokens.gif";
				break;
				
			case SignGroundTransit:
				imageName = @"transit.gif";
				break;
				
			case SignTrash:
				imageName = @"trash.gif";
				break;
				
			case SignWomensRoom:
				imageName = @"womensrr.gif";
				break;
				
			case SignMugWashStation:
				imageName = @"beer28.jpeg";
				break;
				
			case SignBeer:
				imageName = @"beer28.jpeg";
				break;
				
			default:
				NSAssert(NO, @"BadSignENUM!");
		}
		// create image
		if (imageName != nil)
			result = [UIImage imageNamed:imageName];
		// cache it
		if (result)
			[sSignCache setObject:result forKey:[NSNumber numberWithInt:sign]];
	}
	return result;
}

+(void)clearCachedData
{
	if (sSignCache)
	{
		[sSignCache autorelease];
		sSignCache = nil;
	}
}

-(id)init
{
	self = [super init];
	if (self)
	{
		mOps = [[NSArray array] retain];
	}
	return self;
}

-(void)addOp:(NSDictionary*) dict
{
	NSArray* newArray = [mOps arrayByAddingObject:dict];
	[mOps release];
	mOps = [newArray retain];
}

+(SMapCanvasGeometryDescriptor) geoDescriptorForFestival:(FestivalDatabase*)db constrainedToWidth:(CGFloat)width insettingViewBy:(CGFloat)inset rotatingByAngle:(CGFloat)degrees
{
	// Given the festbial database, db, calculate the union of all the locatable objects' shapes' extents.
	NSArray* locs = [[FestivalDatabase sharedDatabase] locatables];
	NSEnumerator* e = [locs objectEnumerator];
	LocatableModelObject* l;
	CGRect biggieRect;
	BOOL firstTime = YES;
	while (nil != (l = [e nextObject]))
	{
		if (firstTime)
		{
			biggieRect = [[l shape] enclosingGeoRectangle];
			firstTime = NO;
		}
		else	
			biggieRect = CGRectUnion(biggieRect, [[l shape] enclosingGeoRectangle]);
	}
	NSLog(@"### size of biggieRect before rotation: %@", NSStringFromCGSize(biggieRect.size));
	if (degrees != 0.0)	// Rotate the biggieRect on its mid point:
	{
		CGFloat xOffset = CGRectGetMidX(biggieRect), yOffset = CGRectGetMidY(biggieRect);
		GeoPoint leftTop = GPMAKE(biggieRect.origin.x - xOffset, biggieRect.origin.y - yOffset);
		GeoPoint rightBottom = GPMAKE(biggieRect.origin.x + biggieRect.size.width - xOffset, biggieRect.origin.y + biggieRect.size.height - yOffset);
		leftTop = Rotate(leftTop, degrees);
		rightBottom = Rotate(rightBottom, degrees);
		biggieRect.size = CGSizeMake(rightBottom.x-leftTop.x, rightBottom.y-leftTop.y);
		NSLog(@"### size of biggieRect AFTER rotating %0.2f: %@", degrees, NSStringFromCGSize(biggieRect.size));
	}
	
	// Now fill out the fields of the geometry object.
	SMapCanvasGeometryDescriptor geo;
	geo.geoBounds = biggieRect;
	geo.rotationDegrees = degrees;
	geo.viewFrame = CGRectMake(0, 0, width, width * (geo.geoBounds.size.height / geo.geoBounds.size.width));
	geo.canvasRect = CGRectInset(geo.viewFrame, inset, inset);
	geo.localViewFrame = CGRectMake(0,0,0,0);

	return geo;
}

-(CGPoint)convertToViewCoordinate:(GeoPoint)geoPoint usingGeometry:(SMapCanvasGeometryDescriptor)geometry
{
	double xRatio = geometry.canvasRect.size.width / geometry.geoBounds.size.width, yRatio = geometry.canvasRect.size.height / geometry.geoBounds.size.height;
	geoPoint.x = (geoPoint.x - geometry.geoBounds.origin.x) * xRatio + geometry.canvasRect.origin.x;	// translate, scale, translate
	geoPoint.y = (geometry.canvasRect.origin.y + geometry.canvasRect.size.height) - ((geoPoint.y - geometry.geoBounds.origin.y) * yRatio);
	geoPoint = Rotate(geoPoint, geometry.rotationDegrees);
	return CGPointMake(geoPoint.x - geometry.localViewFrame.origin.x, geoPoint.y -  geometry.localViewFrame.origin.y);
}

-(GeoPoint)convertToGeoCoordinate:(CGPoint)point usingGeometry:(SMapCanvasGeometryDescriptor)geometry
{
	NSAssert(NO, @"I haven't been implemented yet, dammit!");
	return GPMAKE(0,0);
}


-(void)renderInContext:(CGContextRef)ctx withGeometry:(SMapCanvasGeometryDescriptor)geometry andScale:(CGFloat)scale
{
	NSDictionary* d;
	NSEnumerator* e = [mOps objectEnumerator];
	CGContextBeginPath(ctx);
	
	while (nil != (d = [e nextObject]))
	{
		ShapeOp op = (ShapeOp) [[d objectForKey:OPKEY_OP] intValue];
		UIColor* fillColor = nil, *strokeColor = nil;

		GeoPoint geoPt = [(NSData*)[d objectForKey:OPKEY_COORD] geoPoint];	// Fetch coordinate if available, and translate-scale-translate to new coordinates.
		CGPoint p;
		p = [self convertToViewCoordinate:geoPt usingGeometry:geometry];
		
		// Grab some params. 
		CGFloat lineWidth = 0;
		CGLineCap cap = kCGLineCapButt;
		CGLineJoin join = kCGLineJoinRound;
		NSNumber* n = [d objectForKey:OPKEY_LINE_CAP_STYLE];
		if (n)
			cap = (CGLineCap) [n intValue];
		n = [d objectForKey:OPKEY_LINE_WIDTH];
		if (n)
			lineWidth = [n floatValue];
		
		switch(op)
		{
			case ShapeMoveTo:
				CGContextMoveToPoint(ctx, p.x, p.y);
				break;
				
			case ShapeLineTo:
				CGContextAddLineToPoint(ctx, p.x, p.y);
				break;
				
			case ShapeStroke:
				strokeColor = [d objectForKey:OPKEY_STROKE_COLOR];
				if (strokeColor)
					CGContextSetStrokeColor(ctx, [strokeColor components]);
				CGContextSetLineCap(ctx, cap);
				CGContextSetLineWidth(ctx, lineWidth);
				CGContextSetLineJoin(ctx, join);
				CGContextStrokePath(ctx);
				break;
				
			case ShapeFill:
				fillColor = [d objectForKey:OPKEY_FILL_COLOR];
				if (fillColor)
					CGContextSetFillColor(ctx, [fillColor components]);
				CGContextFillPath(ctx);
				break;
				
			case ShapeFillThenStroke:
				fillColor = [d objectForKey:OPKEY_FILL_COLOR];
				if (fillColor)
					CGContextSetFillColor(ctx, [fillColor components]);
				strokeColor = [d objectForKey:OPKEY_STROKE_COLOR];
				if (strokeColor)
					CGContextSetStrokeColor(ctx, [strokeColor components]);
				CGContextSetLineCap(ctx, cap);
				CGContextSetLineWidth(ctx, lineWidth);
				CGContextSetLineJoin(ctx, join);
				CGContextDrawPath(ctx, kCGPathEOFillStroke);
				break;
			
			case ShapeSign:
			{
				UIImage* img = [Shape imageForSign:(ShapeSignType)[[d objectForKey:OPKEY_SIGN] intValue]];
				if (img)
				{
					CGSize sz = img.size;
					CGRect r = CGRectMake(p.x - sz.width / 2, p.y - sz.height / 2, sz.width, sz.height);
					[img drawInRect:r];
				}
				break;
			}
				
			case ShapeTree:
			{	// For now, just draw a circle.
				TreeType tt = [[d objectForKey:OPKEY_TREE] intValue];
				int treeSize = (10 + (8 * tt)) * scale;
				CGRect treeRect = CGRectMake(p.x - treeSize / 2, p.y - treeSize / 2, treeSize, treeSize);
				CGContextSetFillColor(ctx, [[UIColor colorWithRed:.44 green:.63 blue:.3 alpha:1.0] components]);
				CGContextFillEllipseInRect(ctx, treeRect);
				CGContextSetStrokeColor(ctx, [[UIColor colorWithRed:0.23 green:0.37 blue:0.17 alpha:1.0] components]);
				CGContextSetLineWidth(ctx, 1.0);
				CGContextStrokeEllipseInRect(ctx, treeRect);
			}	
				break;
				
			case ShapeRect:
			{
				CGFloat rotate = [[d objectForKey:OPKEY_ROTATION_DEG] floatValue];				
				SRectPair pair = [self _pairForRectOp:d andGeometry:&geometry];
				CGContextSaveGState(ctx);
				fillColor = [d objectForKey:OPKEY_FILL_COLOR];
				if (fillColor)
					CGContextSetFillColor(ctx, [fillColor components]);
				strokeColor = [d objectForKey:OPKEY_STROKE_COLOR];
				if (strokeColor)
					CGContextSetStrokeColor(ctx, [strokeColor components]);
				if (rotate != 0.0)
				{
					CGContextTranslateCTM(ctx, CGRectGetMidX(pair.viewRect), CGRectGetMidY(pair.viewRect));
					CGContextRotateCTM(ctx, DegreesToRadians(rotate));
					CGContextTranslateCTM(ctx, -CGRectGetMidX(pair.viewRect), -CGRectGetMidY(pair.viewRect));
				}
				CGContextAddRect(ctx, pair.viewRect);
				CGContextDrawPath(ctx, kCGPathEOFillStroke);
				CGContextRestoreGState(ctx);
			}
				break;

			default:
				NSAssert(NO, @"bad draw opcode!");
		}
	}
}

-(CGRect) enclosingViewRectangeForGeometry:(SMapCanvasGeometryDescriptor)geometry	// Given a canvas rect in view coordinates, return the shape's enclosing  rectangle, also in view coordinates. Canvas = the portion we wish to map.
{
	// find min and max vertices etc.
	MinMax mm = MinMaxInit();
	NSDictionary* d;
	NSEnumerator* e = [mOps objectEnumerator];
	
	while (nil != (d = [e nextObject]))
	{
		// For right now, just look for points:
		NSData* data = (NSData*) [d objectForKey:OPKEY_COORD];
		ShapeOp op = (ShapeOp) [[d objectForKey:OPKEY_OP] intValue];
		if (data)
		{
			GeoPoint p = Rotate([data geoPoint], geometry.rotationDegrees);
			CGPoint cgP = [self convertToViewCoordinate:p usingGeometry:geometry];
			mm = MinMaxForCGPoint(mm, cgP);
			
			CGRect anObjectRectangle = CGRectZero;
			
			// For unscaled objects (signs, labels etc.) we will like to compute their actual view rectangles:
			if (op == ShapeSign)
			{
				UIImage* img = [Shape imageForSign:(ShapeSignType)[[d objectForKey:OPKEY_SIGN] intValue]];
				CGSize sz = img.size;
				anObjectRectangle = CGRectMake(cgP.x-(sz.width/2), cgP.y - (sz.height/2), sz.width, sz.height);
			}
			
			if (op == ShapeRect)
			{
				SRectPair pair = [self _pairForRectOp:d andGeometry:&geometry];
				anObjectRectangle = pair.viewRect;
			}
			
			// If we have a bounds rectangle, then min/max it, as well.
			if (!CGRectEqualToRect(anObjectRectangle, CGRectZero))
			{
				mm = MinMaxForCGRect(mm, anObjectRectangle);
			}
		}
	}
	
	return CGRectFromMinMax(mm);
}

-(NSString*)description
{
	return [NSString stringWithFormat:@"Shape contains %d ops.", [mOps count]];
}

@end

@implementation NSData (GeoPoint)
+(NSData*)dataWithGeoPoint:(GeoPoint)p
{
	return [NSData dataWithBytes:&p length:sizeof(p)];
}

-(GeoPoint)geoPoint
{
	GeoPoint p;
	[self getBytes:&p length:sizeof(p)];
	return p;
}
@end