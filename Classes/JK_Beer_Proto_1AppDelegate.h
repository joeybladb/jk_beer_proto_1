//
//  JK_Beer_Proto_1AppDelegate.h
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 3/29/09.
//  Copyright Vernier Software & Technology 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JK_Beer_Proto_1AppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

