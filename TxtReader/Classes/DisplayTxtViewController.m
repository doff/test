//
//  DisplayTxtViewController.m
//  TxtReader
//
//  Created by wang macawwang on 10-6-17.
//  Copyright 2010 xxx. All rights reserved.
//

#import "DisplayTxtViewController.h"


@implementation DisplayTxtViewController
@synthesize _mDisplayView ;
@synthesize _xOffset , _yOffset , _fontColor , _fontSize ;
@synthesize fileName ;
@synthesize loadActiveView ;

#pragma mark -
#pragma mark Initialization
-(id)initWithTxtName:(NSString*)txtName 
{
	if(self = [super init])
	{
		
		fileName = [[NSString alloc]initWithString:txtName];
		
		_xOffset = 0 ; 
		_yOffset = 0 ;
		_fontColor = [UIColor blackColor] ;
		_fontSize = 24.0f ;
		
		self.title = txtName;
		 UIBarButtonItem *writeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(reloadTxt)];
		 self.navigationItem.rightBarButtonItem = writeButton;
		 [writeButton release];
		 
		 // navigationitem left 
		 UIBarButtonItem *bbsButton = [[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backToMainViewController)];
		 self.navigationItem.leftBarButtonItem = bbsButton;
		 [bbsButton release];
		 
		
		_mDisplayView = [[UITextView alloc]initWithFrame: CGRectMake( 0 , 0, 320, 460)];
		[_mDisplayView setTextColor: _fontColor];
		[_mDisplayView setEditable:FALSE];
		_mDisplayView.delegate = self ;
		[_mDisplayView setFont:[UIFont boldSystemFontOfSize: _fontSize]];
		[self.view addSubview: _mDisplayView];
		
		loadActiveView = [UIActivityIndicatorView alloc];
		[loadActiveView initWithFrame:CGRectMake(160 - 16, 240 - 16 , 32, 32)];
		[loadActiveView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
		[loadActiveView setTag:1];
		
	
	}
	return self ;
}
-(void)reloadTxt 
{
	[self loadOffset];
	// Points to path in documents folder in real app.
	NSString* path = fileName; 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
														 NSUserDomainMask,
														 YES);
	NSString *fullPath = [[paths lastObject] stringByAppendingPathComponent:path];
	NSString * stringSources = [NSString stringWithContentsOfFile:fullPath encoding: NSUTF8StringEncoding error:nil] ;
	[_mDisplayView setText:stringSources];
	[_mDisplayView setContentOffset:CGPointMake( _xOffset , _yOffset )];
	
	


}
-(void)backToMainViewController
{
	
	[self.navigationController popViewControllerAnimated:TRUE];

}
-(void)startLoad 
{
	[self.view addSubview:loadActiveView];
	[loadActiveView startAnimating];
	[self reloadTxt];
}
-(void)endLoad 
{
	[loadActiveView stopAnimating];
	[loadActiveView removeFromSuperview];
}
#pragma mark  UIViewController --------------------------------------------------
-(void)viewWillAppear:(BOOL)animated
{
	[self startLoad];
}
-(void)viewDidAppear:(BOOL)animated
{
	[self endLoad];
}
-(void)viewWillDisappear:(BOOL)animated
{
	[self saveOffset];
}
-(void)viewDidDisappear:(BOOL)animated
{

}
-(void)loadOffset 
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	NSString *path = [documentsDirectoryPath 
					  stringByAppendingPathComponent:@"offset.plist"];
	NSMutableDictionary *plist = [NSDictionary dictionaryWithContentsOfFile: path];
	NSArray * array = [plist objectForKey:self.fileName];
	_xOffset = [[array objectAtIndex: 0 ] floatValue] ;
	_yOffset = [[array objectAtIndex: 1 ] floatValue] ;
}
-(void)saveOffset 
{
	
	
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	NSString *path = [documentsDirectoryPath 
					  stringByAppendingPathComponent:@"offset.plist"];
	NSMutableDictionary *plist = [[NSMutableDictionary dictionaryWithContentsOfFile: path]retain];
	NSArray * array =[NSArray arrayWithObjects:
					  
					  [NSString stringWithFormat:@"%0.0f" , _xOffset] ,
					  [NSString stringWithFormat:@"%0.0f" , _yOffset] , nil];
	[plist setObject:array forKey:self.fileName];
	[plist writeToFile:path atomically:YES];
	[plist release];
	
	
}
#pragma mark  UIScrollView-----------------------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView              // any offset change
{
	_xOffset = scrollView.contentOffset.x ; 
	_yOffset = scrollView.contentOffset.y ;
}
#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	
	[loadActiveView release];
	[fileName release];
	[_mDisplayView release];
    [super dealloc];

}


@end

