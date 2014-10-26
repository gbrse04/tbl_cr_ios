//
//  GalleryDetailViewController.m
//  TableCross
//
//  Created by DANGLV on 24/10/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "GalleryDetailViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface GalleryDetailViewController ()

@end

@implementation GalleryDetailViewController

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
     [self setupTitle:@"写真詳細" isShowSetting:YES andBack:YES];
    
  
    self.scrollMain =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, 320, 350)];
    self.scrollMain.delegate = self;
    
    [self.view addSubview:self.scrollMain];
    
    NSLog(@"Scroll Height : %f",self.scrollMain.frame.size.height);
    
    for (NSInteger i=0 ;i < self.arrData.count; i++) {
        
        [self.scrollMain addSubview:[self creatViewForGridItem:CGRectMake(self.scrollMain.frame.size.width*i, 0, self.scrollMain.frame.size.width, self.scrollMain.frame.size.height ) withIndex:i]];
    }
 
    [self.scrollMain setPagingEnabled:TRUE];
    [self.scrollMain  setContentSize:CGSizeMake(self.scrollMain.frame.size.width * self.arrData.count, self.scrollMain.frame.size.height)];
    
    [self.scrollMain scrollRectToVisible:CGRectMake(self.scrollMain.frame.size.width*self.currentPage, 0, self.scrollMain.frame.size.width, self.scrollMain.frame.size.height) animated:YES];
    
    
      self.lblCount.text = [NSString stringWithFormat:@"%d/%d",self.currentPage+1,self.arrData.count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIImageView*)creatViewForGridItem:(CGRect)buttonFrame withIndex:(NSInteger)index {
    
    
    NSDictionary *dictGallery=(NSDictionary*)[self.arrData objectAtIndex:index];
    UIImageView *view;
    
    view = [[UIImageView alloc] initWithFrame:CGRectMake(buttonFrame.origin.x+5, buttonFrame.origin.y, buttonFrame.size.width-10, buttonFrame.size.height)];
       
    NSString *url = [[dictGallery  objectForKey:@"imageUrl"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [view setImageWithURL:[NSURL URLWithString:url] placeholderImage:Nil usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [view setContentMode:UIViewContentModeScaleAspectFit];
    
    return view;
    
}

#pragma mark Scroll Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView {
    
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.currentPage=index;
    self.lblCount.text = [NSString stringWithFormat:@"%d/%d",index+1,self.arrData.count];
    
}

@end
