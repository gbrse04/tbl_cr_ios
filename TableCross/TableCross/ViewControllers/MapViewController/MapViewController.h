//
//  MapViewController.h
//  TableCross
//
//  Created by DANGLV on 04/10/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import "RestaurantObj.h"
#import "MyPinAnnotationView.h"
#import "BusAnnotation.h"
#import "CalloutBusView.h"
#import <CoreLocation/CoreLocation.h>
#import "MKMapView+ZoomLevel.h"


@interface MapViewController : BaseViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,retain) RestaurantObj *restaurant;
@end
