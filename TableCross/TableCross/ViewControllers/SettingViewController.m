//
//  SettingViewController.m
//  TableCross
//
//  Created by DANGLV on 14/09/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    // Do any additional setup after loading the view from its nib.
    [self setupTitle:@"設定" isShowSetting:NO andBack:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
	[super viewWillAppear:animated];
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
}


#pragma mark - IBOutlet Actions

- (IBAction)onSave:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)onSetttingChange:(id)sender {
    
    UIButton *btn = sender;
    [btn setSelected:![btn isSelected]];
    switch (btn.tag) {
        case 4:
            break;
        case 5:
            
            break;
        case 6:
            
            break;


            
        default:
            break;
    }
}

- (IBAction)onSaveBottom:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
