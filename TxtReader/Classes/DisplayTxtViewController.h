//
//  DisplayTxtViewController.h
//  TxtReader
//
//  Created by wang macawwang on 10-6-17.
//  Copyright 2010 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DisplayTxtViewController : UIViewController <UITextViewDelegate , UIScrollViewDelegate>{

	float _yOffset ;
	float _xOffset ;
	float _fontSize ;
	UIColor * _fontColor ;
	UITextView * _mDisplayView ;
	NSString * fileName ;
	
	UIActivityIndicatorView * loadActiveView ;
}

@property(nonatomic,assign)UITextView * _mDisplayView ;
@property(nonatomic,assign)UIColor * _fontColor ;
@property(nonatomic,assign)	NSString * fileName ;
@property(nonatomic,assign)UIActivityIndicatorView * loadActiveView ;
@property float _yOffset ;
@property float _xOffset ;
@property float _fontSize ;
-(id)initWithTxtName:(NSString*)txtName ;
-(void)backToMainViewController;
-(void)reloadTxt ;
-(void)startLoad ;
-(void)endLoad ;
-(void)loadOffset ;
-(void)saveOffset ;
@end
