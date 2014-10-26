//
//  GalleryListViewController.m
//  TableCross
//
//  Created by DANGLV on 24/10/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "GalleryListViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface GalleryListViewController ()

@end

#define kWidthItem 80
#define kHeightItem 80
#define kNumberColum 4

@implementation GalleryListViewController

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
     [self setupTitle:@"写真" isShowSetting:YES andBack:YES];
    if(self.arrData)
    {
        [self.tblImage reloadData];
    }
//    [self loadData];
    
}
-(void)loadData{
    
    START_LOADING;
    [[APIClient sharedClient] getImages:self.restautId withsucess:^(AFHTTPRequestOperation *operation, id responseObject) {

        STOP_LOADING;
        if([[responseObject objectForKey:@"success"] boolValue])
        {
            self.arrData = [responseObject objectForKey:@"items"];
            if(!self.arrData)
            {
                [Util showError:responseObject];
//                [self.navigationController popViewControllerAnimated:YES];
            }
                else
            [self.tblImage reloadData];
        }
        else
        {
            [Util showError:responseObject];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        STOP_LOADING;
        SHOW_NETWORK_ERROR;
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview Delegate and DataSources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (NSInteger)[self.arrData count]/kNumberColum;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentify = [NSString stringWithFormat:@"Cell %i-%i", indexPath.section, indexPath.row];
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        [cell setBackgroundColor:[UIColor blackColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    for (NSInteger ja=0; ja < kNumberColum ; ja++) {
        if((indexPath.row*kNumberColum+ja)<[self.arrData count])
        {
                [cell.contentView addSubview:[self creatViewForGridItem:CGRectMake(ja*kWidthItem, 0, kWidthItem-3, kHeightItem -3) withIndex:(indexPath.row*kNumberColum+ja) andCell:cell andColumnIndex:ja]];
            
        }
    }

    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    
    cell.frame = CGRectMake(0, 0,320,kHeightItem);
    return cell;
}


-(UIImageView*)creatViewForGridItem:(CGRect)buttonFrame withIndex:(NSInteger)index andCell:(UITableViewCell*)containerCell andColumnIndex:(NSInteger)columnIndex{
    
    
    NSDictionary *dictGallery=(NSDictionary*)[self.arrData objectAtIndex:index];
    UIImageView *view;
    
    if(![containerCell viewWithTag:1999+columnIndex])
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidthItem-3, kHeightItem-3)];
        view.tag=1999+columnIndex;
    }
    else {
        
        view =(UIImageView*)[containerCell viewWithTag:1999+columnIndex];
        [view removeFromSuperview];
    }
    
    view.frame=buttonFrame;
    view.tag = index;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onChoice:)];
    singleTap.numberOfTapsRequired = 1;
    [view setUserInteractionEnabled:YES];
    [view addGestureRecognizer:singleTap];
    NSString *url = [[dictGallery  objectForKey:@"imageUrl"]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [view setImageWithURL:[NSURL URLWithString:url] placeholderImage:Nil usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

    view.clipsToBounds = true;
    [view setContentMode:UIViewContentModeScaleAspectFill];
    
    return view;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeightItem;
}

#pragma mark Gallery delegate

-(void)onChoice:(UITapGestureRecognizer*)touchImage{
    
    NSInteger  clickedIndex = ((UIImageView*)touchImage.view).tag;
    
    NSLog(@"Clicked: %d",clickedIndex);
    
    GalleryDetailViewController *vc =[[GalleryDetailViewController alloc] initWithNibName:@"GalleryDetailViewController" bundle:nil];
    vc.arrData =self.arrData;
    vc.currentPage = clickedIndex;
    
    [self.navigationController pushViewController:vc animated:YES];

}

@end
