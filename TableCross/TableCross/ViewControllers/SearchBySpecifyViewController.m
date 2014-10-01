//
//  SearchBySpecifyViewController.m
//  TableCross
//
//  Created by DangLV on 10/1/14.
//  Copyright (c) 2014 Lemon. All rights reserved.
//

#import "SearchBySpecifyViewController.h"

@interface SearchBySpecifyViewController ()

@end

@implementation SearchBySpecifyViewController

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
    [self setupTitle:@"特集から探す" isShowSetting:YES andBack:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super  viewWillAppear:animated];
    // Set title
    
    self.navigationItem.title=@"特集から探す";
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationItem.title=@"現在地結果";
}

#pragma mark  - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if(![self.txtSearch.text isEqualToString:@""])
    {
        
        [self makeSearch:self.txtSearch.text distance:@"1"];
      
    }
    return  YES;
    
}

-(void)makeSearch:(NSString*)keyword distance:(NSString*)distance{
    
    
    START_LOADING;
    [[APIClient sharedClient] searchByKeyWord:keyword type:@"1" latitude:[NSString stringWithFormat:@"%f",gCurrentLatitude] longitude:[NSString stringWithFormat:@"%f",gCurrentLongitude] distance:distance total:@"-1" withSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response : %@",responseObject);
        STOP_LOADING;
        if([[responseObject objectForKey:@"success"] boolValue])
            
        {
            self.arrData = [APIClient parserListRestaunt:responseObject];
//            if([self.arrData count]== 0)
//            {
                [Util showMessage:@"No result found" withTitle:@"Result"];
                return ;
//            }
                   }
        else
            [Util showError:responseObject];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        STOP_LOADING;
        SHOW_NETWORK_ERROR;
    }];
    
}


@end
