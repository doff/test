//
//  TxtReaderViewController.m
//  TxtReader
//
//  Created by wang macawwang on 10-6-17.
//  Copyright xxx 2010. All rights reserved.
//

#import "TxtReaderViewController.h"
#import"DisplayTxtViewController.h"

@implementation TxtReaderViewController
@synthesize _mTableViewList ;
@synthesize listName ;

/*

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
	

    }
    return self;
}
 */
-(id)init
{
	if(self = [super init])
	{
		[self CreateView];
	}
	return self ;
}

-(void)CreateView 
{
	self.title = @"TxtReader" ;
	self.view.userInteractionEnabled = TRUE ;
	//self.tabBarItem = [[[UITabBar alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:101]autorelease];
	self.tabBarItem.title = @"TxtReader";
	listName = [[NSMutableArray alloc]init];
	[listName addObject:@"ReadMe.txt"];
	[listName addObject:@"佛本是道.txt"];
	[listName addObject:@"codeguid.txt"];
	CGRect rectFrame = CGRectMake(0, 0, 320, 460) ;
	_mTableViewList = [[UITableView alloc]initWithFrame:rectFrame style:UITableViewStylePlain];
	_mTableViewList.delegate = self ;
	_mTableViewList.dataSource = self ;
	[self.view addSubview: _mTableViewList];
	
	loadActiveView = [UIActivityIndicatorView alloc];
	[loadActiveView initWithFrame:CGRectMake(160 - 16, 240 - 16 , 32, 32)];
	[loadActiveView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
	[loadActiveView setTag:1];
	

}
#pragma mark  UIActivityIndicatorView------------
-(void)startLoad 
{
	[self.view addSubview:loadActiveView];
	[loadActiveView startAnimating];
	
}
-(void)endLoad 
{
	[loadActiveView stopAnimating];
	[loadActiveView removeFromSuperview];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
#pragma mark  UITableView------------------------------------------

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	if( NULL == listName ) return 0 ;
	return (NSInteger)[listName count];

}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell * _cell = nil ;
	CGRect rectFrame = CGRectMake(0, 0, 320, 30) ;
	_cell = [[[UITableViewCell alloc]initWithFrame:rectFrame reuseIdentifier: @""]autorelease];
	NSString * txtName = [listName objectAtIndex: indexPath.row] ;
	UITextView * textViewDisplayName = [[UILabel alloc] initWithFrame: _cell.frame];
	[textViewDisplayName setFont:[UIFont boldSystemFontOfSize:24]];
	[textViewDisplayName setText:txtName];
	[_cell addSubview: textViewDisplayName];
	[txtName release];
	return _cell ;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;          // Default is 1 if not implemented
{
	return 1 ;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[NSThread detachNewThreadSelector:@selector(startLoad) toTarget:self withObject:nil];
	NSString * txtName = [listName objectAtIndex: indexPath.row];
	DisplayTxtViewController * txtViewController = [[DisplayTxtViewController alloc]initWithTxtName:txtName];
	[self.navigationController pushViewController:txtViewController animated:TRUE];
	[txtViewController release];
	[self endLoad];
	
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[loadActiveView release];
	[listName release];
	[_mTableViewList release];
    [super dealloc];
}

@end
