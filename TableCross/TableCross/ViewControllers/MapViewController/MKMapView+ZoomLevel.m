//
//  MKMapView+ZoomLevel.m
//  TableCross
//
//  Created by DANGLV on 05/10/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import "MKMapView+ZoomLevel.h"

@implementation MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated {
    MKCoordinateSpan span = MKCoordinateSpanMake(0, 360/pow(2, zoomLevel)*self.frame.size.width/256);
    [self setRegion:MKCoordinateRegionMake(centerCoordinate, span) animated:animated];
}


-(double) getZoomLevel {
    return log2(360 * ((self.frame.size.width/256) / self.region.span.longitudeDelta));
}

@end
