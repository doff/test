//
//  TxtReaderViewController.h
//  TxtReader
//
//  Created by wang macawwang on 10-6-17.
//  Copyright xxx 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TxtReaderViewController : UIViewController<UITableViewDelegate , UITableViewDataSource> {
	UITableView * _mTableViewList ;
	NSMutableArray * listName ;
	UIActivityIndicatorView * loadActiveView ;
	
}
@property(nonatomic , assign) UITableView * _mTableViewList ;
@property(nonatomic , assign)  NSMutableArray * listName ;
-(id)init;
-(void)CreateView ;
-(void)startLoad ;
-(void)endLoad ;
@end

