//
//  MKMapView+ZoomLevel.h
//  TableCross
//
//  Created by DANGLV on 05/10/2014.
//  Copyright (c) Năm 2014 Lemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface MKMapView (ZoomLevel)
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

-(double) getZoomLevel;
@end