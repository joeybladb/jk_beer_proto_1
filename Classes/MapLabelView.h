//
//  MapLabelView.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 4/4/09.
//  Copyright 2009 Vernier Software & Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LocatableModelObject;

@interface MapLabelView : UIView {
	IBOutlet UIView*	mLabelView;
	IBOutlet UILabel*	mLabelText;
	IBOutlet UIButton*	mInfoButton;
	
	id mNibItems;
	LocatableModelObject* mObject;
	id	mClickTarget;
	SEL mClickSelector;
}
-(id)initWithFrame:(CGRect)frame andObject:(LocatableModelObject*)object;
-(void)setClickTarget:(id)target andSelector:(SEL)selector;

-(void)onClick:(id)sender;
@end
