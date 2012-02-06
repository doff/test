//
//  TxtReaderAppDelegate.m
//  TxtReader
//
//  Created by wang macawwang on 10-6-17.
//  Copyright xxx 2010. All rights reserved.
//

#import "TxtReaderAppDelegate.h"
#import "TxtReaderViewController.h"

@implementation TxtReaderAppDelegate
@synthesize window;
@synthesize viewController;
@synthesize navController ;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	viewController = [[TxtReaderViewController alloc]init];
	
	 navController = [[UINavigationController alloc]initWithRootViewController:viewController];
	navController.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"BookList" 
															 image:nil
															   tag:'p'] autorelease];
	
    // Override point for customization after app launch    
    [window addSubview:[navController view]];
    [window makeKeyAndVisible];
	[self bangfile];
	
	
	return YES;
}

-(void)bangfile
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];	
	NSMutableArray*arrayfilename=[[NSMutableArray alloc] init];	
	//codeguid.txt
	[arrayfilename addObject:[NSString stringWithFormat:@"codeguid.txt"]];
	[arrayfilename addObject:[NSString stringWithFormat:@"佛本是道.txt"]];
	[arrayfilename addObject:[NSString stringWithFormat:@"ReadMe.txt"]];
	[arrayfilename addObject:[NSString stringWithFormat:@"offset.plist"]];
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];	
	NSString *writableDBPath;
	NSString *defaultDBPath;
	for(int i=0;i<[arrayfilename count];i++)
	{
		//NSLog([arrayfilename objectAtIndex: i ] ) ;
		writableDBPath = [documentsDirectory stringByAppendingPathComponent:[arrayfilename objectAtIndex:i]];
		success = [fileManager fileExistsAtPath:writableDBPath];
		if (success) break;
		// The writable database does not exist, so copy the default to the appropriate location.
		defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[arrayfilename objectAtIndex:i]];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
		if (!success) {
			NSLog(@"%@\n" , [arrayfilename objectAtIndex: i ]) ;
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
			NSLog(@"Failed to create writable database file with message '%@'.", [error localizedDescription]);		
		}
	}
	[ arrayfilename release];
	[pool release];
	NSLog(@"end load sources ~ \n "  ) ;
}
- (void)dealloc {
	[navController release];
    [viewController release];
    [window release];
    [super dealloc];
}


@end
