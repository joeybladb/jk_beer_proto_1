//
//  Shape.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/4/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import "Shape.h"
#import "UIColor+Components.h"

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



NSMutableDictionary* sSignCache = nil;

@implementation Shape

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

-(CGRect) enclosingRectangleShouldFlip:(BOOL)flip	// Calculate a rectangle big enough to hold all the bits of the shape.
{
	// find min and max vertices etc.
	double minX = 1000000.0, maxX = -1000000.0, minY = 1000000.0, maxY = -1000000.0;
	NSDictionary* d;
	NSEnumerator* e = [mOps objectEnumerator];

	while (nil != (d = [e nextObject]))
	{
		// For right now, just look for points:
		GeoPoint* p = [d objectForKey:OPKEY_COORD];
		if (p)
		{
			minX = MIN(minX, p.x);
			maxX = MAX(maxX, p.x);
			minY = MIN(minY, p.y);
			maxY = MAX(maxY, p.y);
		}
	}
	
	if (flip)
		return CGRectMake(minX, maxY, maxX-minX, maxY-minY); 

	return CGRectMake(minX, minY, maxX-minX, maxY-minY); 
}

-(void)renderInContext:(CGContextRef)ctx withViewFrame:(CGRect)frame
{
	CGRect encFrame = [self enclosingRectangleShouldFlip:NO];
	double xRatio = frame.size.width / encFrame.size.width, yRatio = frame.size.height / encFrame.size.height;
	
	NSDictionary* d;
	NSEnumerator* e = [mOps objectEnumerator];
	
//	int nPt = 0;
	
	while (nil != (d = [e nextObject]))
	{
		ShapeOp op = (ShapeOp) [[d objectForKey:OPKEY_OP] intValue];
		UIColor* fillColor = nil, *strokeColor = nil;

		GeoPoint* p = [d objectForKey:OPKEY_COORD];	// Fetch coordinate if available, and translate-scale-translate to new coordinates.
		if (p)
		{
			p.x = (p.x - encFrame.origin.x) * xRatio + frame.origin.x;
			p.y = frame.size.height - ((p.y - encFrame.origin.y) * yRatio /*+ frame.origin.y*/);
//			NSLog(@"Draw coordinate: %@", NSStringFromCGPoint(p));
//			NSString* str = [NSString stringWithFormat:@"%d : (%0.3f,%0.3f)", nPt, p.x, p.y];
//			CGContextSelectFont(ctx, "Courier", 14, kCGEncodingMacRoman);
//			CGAffineTransform transform = CGAffineTransformMake(
//											  1.0,0.0, 0.0, -1.0, 0.0, 0.0
//			);
//			
//			CGContextSetTextMatrix(ctx, transform);			
//			CGContextShowTextAtPoint(ctx, p.x + 8, p.y + 8, [str UTF8String], [str length]);
//			nPt++;
		}
		
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

			default:
				NSAssert(NO, @"bad draw opcode!");
				
		}
	}
}

-(CGRect) enclosingViewRectangeForCanvasRect:(CGRect)canvas	// Given a canvas rect in view coordinates, return the shape's enclosing  rectangle, also in view coordinates. Canvas = the portion we wish to map.
{
	return CGRectMake(0, 0, 0, 0);
}

@end

@implementation GeoPoint
@synthesize x,y;
-(id)init
{
	self = [super init];
	if (self)
	{
		x=y=0.0;
	}
	return self;
}
@end
