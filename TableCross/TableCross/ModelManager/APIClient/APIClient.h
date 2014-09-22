//
//  APIClient.h
//  TableCross
//
//  Created by TableCross on 9/18/14.
//  Copyright (c) 2014 Lemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "RestaurantObj.h"


typedef void(^TTResponseSuccess)(AFHTTPRequestOperation *operation, id responseObject);
typedef void(^TTResponseFailure)(AFHTTPRequestOperation *operation, NSError *error);

@interface APIClient : AFHTTPClient

+ (APIClient *)sharedClient;

- (void)login:(NSString*)email pass:(NSString*)pass loginType:(NSString*)type areaId:(NSString*)areaId withSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;

-(void)registerWithEmail:(NSString*)email pass:(NSString*)pass regionId:(NSString*)regionId refUserId:(NSString*)refId withSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;


- (void)logout:(NSString*)token succes:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
- (void)changePass:(NSString*)oldPass newPass:(NSString*)newPass success:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
- (void)getListAresWithSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
- (void)getUserInfoWithSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
- (void)searchByKeyWord:(NSString*)keyword type:(NSString*)searchType latitude:(NSString*)lat longitude:(NSString*)longitude distance:(int)radius total:(NSString*)total withSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
- (void)updateUserEmail:(NSString*)email phone:(NSString*)phone birthday:(NSString*)birthday sucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;

//+(NSMutableArray)parserListAres:(id)dict;
+(NSMutableArray*)parserListRestaunt:(id)dict;

@end