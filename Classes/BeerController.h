//
//  BeerController.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 3/29/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BeerController : UIViewController {
	IBOutlet UITextView* mTitle;
	IBOutlet id mRating;
	IBOutlet id mRatingText;
	unsigned mBeerNumber;	// Might someday be a UUID or a beer object.
}
-(void)setBeerNum:(unsigned)beerNum;
@end
