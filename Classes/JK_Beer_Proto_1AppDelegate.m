//
//  JK_Beer_Proto_1AppDelegate.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 3/29/09.
//  Copyright Vernier Software & Technology 2009. All rights reserved.
//

#import "JK_Beer_Proto_1AppDelegate.h"
#import "RootViewController.h"


@implementation JK_Beer_Proto_1AppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
