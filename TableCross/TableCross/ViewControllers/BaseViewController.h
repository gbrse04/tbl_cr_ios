//
//  BaseViewController.h
//  TableCross
//
//  Created by DANGLV on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void) setupTitle:(NSString*)title isShowSetting:(BOOL)showSetting andBack:(BOOL)isShowBack;
- (void) setupTitle:(NSString*)title isShowSetting:(BOOL)showSetting andBack:(BOOL)isShowBack andBackTitle:(NSString*)title;

@end
