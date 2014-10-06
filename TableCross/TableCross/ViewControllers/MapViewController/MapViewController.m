//
//  MapViewController.m
//  TableCross
//
//  Created by DANGLV on 04/10/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize restaurant;

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
    [self setupTitle:@"Map" isShowSetting:YES andBack:YES];
    [self bindData];
}

-(void)bindData {
    
    self.mapView.showsUserLocation = YES;
//    31.060795, -88.294256
    CLLocationCoordinate2D coord = {[restaurant.latitude floatValue],[restaurant.longitude floatValue]};
    
    [self.mapView setCenterCoordinate:coord zoomLevel:12 animated:YES];
//    CLLocationCoordinate2D coord = {31.060795, -88.294256};

    BusAnnotation* busAnno = [[BusAnnotation alloc] init];
    busAnno.coordinate = coord;
    busAnno.restaurant = restaurant;
    [self.mapView addAnnotation:busAnno];
    
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - MapView Delegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[MKUserLocation class]])
        return Nil;
    NSString* annotationIdentifier = @"BusViewAnnotation";
    MyPinAnnotationView* pinView = (MyPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    if(!pinView)
    {
        pinView = [[MyPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier] ;
        pinView.image = [UIImage imageNamed:@"icon_map"];
        //pinView.animatesDrop = NO;
    }else
    {
        pinView.annotation = annotation;
    }
    
    return pinView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if(![view.annotation isKindOfClass:[MKUserLocation class]]) {
        CalloutBusView *calloutView = (CalloutBusView *)[[[NSBundle mainBundle] loadNibNamed:@"CalloutBusView" owner:nil options:nil] objectAtIndex:0];
        CGRect calloutViewFrame = calloutView.frame;
        calloutViewFrame.origin = CGPointMake(-calloutViewFrame.size.width/2 + 16 , -calloutViewFrame.size.height- 5);
        calloutView.frame = calloutViewFrame;
        BusAnnotation* busAnno = [view annotation];
        calloutView.restaurant = busAnno.restaurant;
        [calloutView setDataWithRestaurant];
        //[calloutView.calloutLabel setText:[(myAnnotation*)[view annotation] title]];
        [view addSubview:calloutView];
        [_mapView setCenterCoordinate:busAnno.coordinate animated:YES];
    }
}

- (void)deselectAllAnnotations
{
    
    NSArray *selectedAnnotations = [self.mapView selectedAnnotations];
    for (int i = 0; i < [selectedAnnotations count]; i++) {
        [self.mapView deselectAnnotation:[selectedAnnotations objectAtIndex:i] animated:NO];
    }
    
}

@end
