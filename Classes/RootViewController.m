//
//  RootViewController.m
//  JK-Beer-Proto-1
//
//  Created by Joseph Kelly on 3/29/09.
//  Copyright Vernier Software & Technology 2009. All rights reserved.
//

#import "RootViewController.h"
#import "JK_Beer_Proto_1AppDelegate.h"
#import "ListController.h"
#import "MapController.h"
#import "LatLongViewController.h"


@implementation RootViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.navigationItem.title = @"Oregon Brewers 2009";
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc]
								   initWithTitle:@"Festival Map"
								   style:UIBarButtonItemStyleBordered
								   target:self
								   action:@selector(gotoMap:)] autorelease];
	self.navigationItem.rightBarButtonItem = addButton;
	
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0)
	{	// this is the top level nav-section
		return 3;
	}
	else if (section == 1)
	{	// this is the Favorites section -- allows quick access to 
		// query the favorites database for number
		return 2;	
	}
	else if (section == 2)
	{	// This is the tours section (completely optional)
		// query the favorites database for number
		return 1;	
	}
	
    return 0;
}

// Accessorize
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellAccessoryDisclosureIndicator;
}

// Header
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	switch (section)
	{
		case 0:
			return @"Beers";
			break;
		case 1:
			return @"Favorites";
			break;
		case 2:
			return @"Tours";
			break;
		default:
			break;
	}
	return @"Wtf?";
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	if (indexPath.section == 0)
	{	// This is the main-navigator:
		switch (indexPath.row)
		{
			case 0:
				cell.text = @"Beers";
				break;
			case 1:
				cell.text = @"Brewers";
				break;
			case 2:
				cell.text = @"Festival Points of Interest";
				break;
			default:
				break;
		}
	}
	else if (indexPath.section == 1)
	{
		switch (indexPath.row)
		{
			case 0:
				cell.text = @"Get Beer Tokens";
				break;
			case 1:
				cell.text = @"Nearest Restroom";
				break;
		}
	}

    return cell;
}


- (void)gotoMap:(id)sender
{
//	MapController *anotherViewController = [[MapController alloc] initWithNibName:@"MapController" bundle:nil];
//	[self.navigationController pushViewController:anotherViewController animated:YES];
//	[anotherViewController release];
	
	LatLongViewController *anotherViewController = [[LatLongViewController alloc] initWithNibName:@"LatLongController" bundle:nil];
	[self.navigationController pushViewController:anotherViewController animated:YES];
	[anotherViewController release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	if (indexPath.section == 1)
		[self gotoMap:self];
	else
	{
		ListController *anotherViewController = [[ListController alloc] initWithNibName:@"ListController" bundle:nil];
		[self.navigationController pushViewController:anotherViewController animated:YES];
		[anotherViewController release];
	}
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}


@end

