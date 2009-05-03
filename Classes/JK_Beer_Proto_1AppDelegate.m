//
//  JK_Beer_Proto_1AppDelegate.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 3/29/09.
//  Copyright Vernier Software & Technology 2009. All rights reserved.
//

#import "JK_Beer_Proto_1AppDelegate.h"
#import "RootViewController.h"
#import "FestivalDatabase.h"
#import "Shape.h"

@implementation JK_Beer_Proto_1AppDelegate

@synthesize window;
@synthesize navigationController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Instantiate the database:
	NSURL* serverURL = [NSURL URLWithString:@"http://beerphest.com/pdx/summary-xml"];
	[[FestivalDatabase alloc] initWithURL:serverURL];
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
	[[FestivalDatabase sharedDatabase] cacheContents];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application      // try to clean up as much memory as possible. next step is to terminate app
{
	[Shape clearCachedData];
}

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
