//
//  APIClient.h
//  TableCross
//
//  Created by DangLV on 9/18/14.
//  Copyright (c) 2014 Lemon. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^TTResponseSuccess)(AFHTTPRequestOperation *operation, id responseObject);
typedef void(^TTResponseFailure)(AFHTTPRequestOperation *operation, NSError *error);

@interface APIClient : AFHTTPClient

+ (APIClient *)sharedClient;

+ (void)login:(NSString*)email pass:(NSString*)pass loginType:(NSString*)type withSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;

+ (void)registerWithEmail:(NSString*)email pass:(NSString*)pass regionId:(NSString*)regionId withSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;


+ (void)getAllRegionWithSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
+ (void)searchByKeyWord:(NSString*)keyword withSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
+ (void)searchByKeyWord:(NSString*)keyword withSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
+ (void)searchByKeyWord:(NSString*)keyword withSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
+ (void)getNewsFeatureWithSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;


@end