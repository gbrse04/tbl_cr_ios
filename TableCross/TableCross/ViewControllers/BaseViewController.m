//
//  BaseViewController.m
//  TableCross
//
//  Created by DANGLV on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import "SettingViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController
{
    
    NSString *backTitle;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;

    if(IS_IOS7)
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated {
    
    
    [super viewDidAppear:YES];
    
    if(IS_IOS7)
    {
        [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
         setTitleTextAttributes:[NSDictionary
                                 dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil]
         forState:UIControlStateNormal];
        [[self.navigationController.navigationBar.subviews lastObject] setTintColor:[UIColor whiteColor]];
    }
    if(backTitle)
    [self.navigationController.navigationBar.backItem setTitle:backTitle];

}

- (void) setupTitle:(NSString*)title isShowSetting:(BOOL)isShowSetting andBack:(BOOL)isShowBack {
    
    self.navigationItem.title = title;
   self.navigationItem.hidesBackButton = NO;
   if(IS_IOS7)
   {
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
     setTitleTextAttributes:[NSDictionary
                             dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil]
     forState:UIControlStateNormal];
        [[self.navigationController.navigationBar.subviews lastObject] setTintColor:[UIColor whiteColor]];
   }
    
  if(isShowSetting)
    {
        UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *settingImage = [UIImage imageNamed:@"btn_setting.png"]  ;
        
        [settingBtn setBackgroundImage:settingImage forState:UIControlStateNormal];
        [settingBtn addTarget:self action:@selector(gotoSetting) forControlEvents:UIControlEventTouchUpInside];
        settingBtn.frame = CGRectMake(0, 0, 20, 20);
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:settingBtn] ;
        self.navigationItem.rightBarButtonItem = backButton;
    }
}

- (void) setupTitle:(NSString*)title isShowSetting:(BOOL)showSetting andBack:(BOOL)isShowBack andBackTitle:(NSString*)backStr{

    backTitle =  backStr;
    [self setupTitle:title isShowSetting:showSetting andBack:isShowBack];
    [self.navigationController.navigationBar.backItem setTitle:backTitle];

    if(IS_IOS7)
    {
        [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
         setTitleTextAttributes:[NSDictionary
                                 dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil]
         forState:UIControlStateNormal];
        [[self.navigationController.navigationBar.subviews lastObject] setTintColor:[UIColor whiteColor]];
    }

}

-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)gotoSetting {
    
    SettingViewController *vc= [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
