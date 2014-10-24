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
#import  "NSString+Extension.h"


typedef void(^TTResponseSuccess)(AFHTTPRequestOperation *operation, id responseObject);
typedef void(^TTResponseFailure)(AFHTTPRequestOperation *operation, NSError *error);

@interface APIClient : AFHTTPClient

+ (APIClient *)sharedClient;

- (void)login:(NSString*)email pass:(NSString*)pass loginType:(NSString*)type areaId:(NSString*)areaId phone:(NSString*)phone withSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;

-(void)registerWithEmail:(NSString*)email name:(NSString*)name pass:(NSString*)pass phone:(NSString*)phone birthday:(NSString*)birthday regionId:(NSString*)regionId refUserId:(NSString*)refId withSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;


- (void)logout:(NSString*)token succes:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
- (void)changePass:(NSString*)oldPass newPass:(NSString*)newPass success:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
- (void)getListAresWithSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
- (void)getUserInfoWithSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
- (void)searchByKeyWord:(NSString*)keyword type:(NSString*)searchType latitude:(NSString*)lat longitude:(NSString*)longitude distance:(NSString*)radius total:(NSString*)total category:(NSString*)category withSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
- (void)updateUserEmail:(NSString*)email kanjiName:(NSString*)name phone:(NSString*)phone birthday:(NSString*)birthday sucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
- (void)getListNotifyAllStart:(NSString*)from total:(NSString*)total sucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
- (void)getListUnpushNotifiycationWithsucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
- (void)getRestaurantInfo:(NSString*)resId withsucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
- (void)getShareLinkWithsucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;
- (void)sendOrder:(NSString*)userId andNumber:(NSString*)numberMeal withsucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;

- (void)getRestaurantByCategory:(NSString*)catId withsucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;

- (void)getImages:(NSString*)resId withsucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure;

//+(NSMutableArray)parserListAres:(id)dict;
+(NSMutableArray*)parserListRestaunt:(id)dict;

@end