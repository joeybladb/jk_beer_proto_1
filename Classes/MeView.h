//
//  MeView.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 5/2/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

// This view draw a representation of the user's current location. All that means is it draws
// some kind of dot. The actual positioning will be done by the MapController, because, you know.

@interface MeView : UIView {
	NSTimer* mECTimer;
}

@end
