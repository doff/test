//
//  TxtReaderAppDelegate.h
//  TxtReader
//
//  Created by wang macawwang on 10-6-17.
//  Copyright xxx 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TxtReaderViewController;

@interface TxtReaderAppDelegate : NSObject <UIApplicationDelegate,UINavigationControllerDelegate> {
    UIWindow *window;
    TxtReaderViewController *viewController;
	UINavigationController * navController ;
}
@property(nonatomic, assign)UINavigationController * navController ;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain)  TxtReaderViewController *viewController;
-(void)bangfile ;
@end

