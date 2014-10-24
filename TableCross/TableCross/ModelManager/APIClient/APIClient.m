//
//  APIClient.m
//  TableCross
//
//  Created by TableCross on 9/18/14.
//  Copyright (c) 2014 Lemon. All rights reserved.
//


#import "AFNetworking.h"
#import "APIClient.h"

static NSString * const BASE_URL = kBaseUrl ;

@implementation APIClient


+ (APIClient *)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json;version=1.0;charset=UTF-8"];
    //[self setDefaultHeader:@"Accept-Charset" value:@"utf-8"];
    //[self setDefaultHeader:@"Content-Type" value:@"application/json,charset=utf-8"];
    
    return self;
}

//
////+ (void)getNewsInCategory:(NSString *)categoryId page:(NSString *)page pageSize:(NSString *)pageSize success:(TTResponseSuccess)success failure:(TTResponseFailure)failure {
////    [[TheThao247APIClient sharedClient] getPath:NEWS_CATEGORY parameters:@{@"cat_id": categoryId, @"page": page, @"pagesize": pageSize} success:success failure:failure];
////}

- (void)login:(NSString*)email pass:(NSString*)pass loginType:(NSString*)type areaId:(NSString*)areaId  phone:(NSString*)phone withSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure {
    
    [[APIClient sharedClient] getPath:kUrlLogin parameters:@{@"email": email,@"msisdn": phone, @"password": pass, @"loginType": type, @"areaId":areaId} success:success failure:failure];
}

- (void)registerWithEmail:(NSString*)email name:(NSString*)name  pass:(NSString*)pass phone:(NSString*)phone birthday:(NSString*)birthday  regionId:(NSString*)regionId refUserId:(NSString*)refId withSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure {
    
      [[APIClient sharedClient] getPath:kUrlRegister parameters:@{@"email": email,@"name": name, @"password": pass, @"deviceId": refId, @"areaId":regionId,@"birthday":birthday,@"msisdn":phone} success:success failure:failure];
}


- (void)logout:(NSString*)token succes:(TTResponseSuccess)success failure:(TTResponseFailure)failure {
      [[APIClient sharedClient] getPath:kUrlLogout parameters:nil success:success failure:failure];
}
- (void)changePass:(NSString*)oldPass newPass:(NSString*)newPass success:(TTResponseSuccess)success failure:(TTResponseFailure)failure {
      [[APIClient sharedClient] getPath:kUrlChangePass parameters:@{@"oldPassword": oldPass, @"newPassword": newPass} success:success failure:failure];
}
- (void)getListAresWithSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure {
      [[APIClient sharedClient] getPath:kUrlGetListArea parameters:nil  success:success failure:failure];
}
- (void)getUserInfoWithSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure {
    
    [[APIClient sharedClient] getPath:kUrlGetUserInfo parameters:nil success:success failure:failure];
    
}


//keyword = [keyword stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//
//NSString *searchUrl = [NSString stringWithFormat:@"%@&searchType=%@&searchKey=%@&longitude=%@&latitude=%@&distance=%@&total=-1",kUrlSearchRestaurant ,searchType,keyword,longitude,lat,radius];

- (void)searchByKeyWord:(NSString*)keyword type:(NSString*)searchType latitude:(NSString*)lat longitude:(NSString*)longitude distance:(NSString*)radius total:(NSString*)total category:(NSString*)category withSuccess:(TTResponseSuccess)success failure:(TTResponseFailure)failure {
    
    if(![[category class] isSubclassOfClass:[NSString class]])
        
        category  = [NSString stringWithFormat:@"%@",category];
        
    if([category isEqualToString:@""])
       [[APIClient sharedClient] getPath:kUrlSearchRestaurant parameters:@{@"searchType": searchType, @"searchKey": keyword, @"longitude":longitude, @"latitude":lat,@"distance":radius,@"total":@"-1"} success:success failure:failure];
    else
        [[APIClient sharedClient] getPath:kUrlSearchRestaurant parameters:@{@"searchType": searchType, @"searchKey": keyword, @"longitude":longitude, @"latitude":lat,@"distance":radius,@"total":@"-1",@"category":category} success:success failure:failure];
    
    
}

- (void)updateUserEmail:(NSString*)email phone:(NSString*)phone birthday:(NSString*)birthday sucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure {
      [[APIClient sharedClient] getPath:kUrlUpdateProfile parameters:@{@"email": email, @"mobile": phone, @"birthday": birthday} success:success failure:failure];
}


- (void)getListNotifyAllStart:(NSString*)from total:(NSString*)total sucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure {
     [[APIClient sharedClient] getPath:kUrlGetListNotification parameters:@{@"from": from, @"total": total} success:success failure:failure];
}
- (void)getListUnpushNotifiycationWithsucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure {
    [[APIClient sharedClient] getPath:kUrlGetUnpushNotification parameters:nil success:success failure:failure];
}

- (void)getRestaurantInfo:(NSString*)resId withsucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure {
    [[APIClient sharedClient] getPath:kUrlGetRestaurantDetail parameters:@{@"restaurantId":resId} success:success failure:failure];
}

- (void)getShareLinkWithsucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure{
    
    [[APIClient sharedClient] getPath:kUrlGetShareLink parameters:nil success:success failure:failure];
}

- (void)sendOrder:(NSString*)restauntId andNumber:(NSString*)numberMeal withsucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure {
  
     [[APIClient sharedClient] getPath:kUrlSendOrder parameters:@{@"restaurantId":restauntId,@"quantity":numberMeal} success:success failure:failure];
}

- (void)getRestaurantByCategory:(NSString*)catId withsucess:(TTResponseSuccess)success failure:(TTResponseFailure)failure {
    
    if(!catId || [catId isEqualToString:@""])
     [[APIClient sharedClient] getPath:kUrlGetRestaurantByCategoryId parameters:nil success:success failure:failure];
    else
     [[APIClient sharedClient] getPath:kUrlGetRestaurantByCategoryId parameters:@{@"categoryId":catId} success:success failure:failure];
}

#pragma mark - Parser Functions

+ (NSMutableArray*)parserListRestaunt:(id)dict {

    NSMutableArray *arrRestaurant = [[NSMutableArray alloc] init];
    
    if(dict)
    {
        NSArray *arr = [dict objectForKey:@"items"];
        RestaurantObj *obj;
        for (NSDictionary *item in arr) {
            obj = [[RestaurantObj alloc] initWithDict:item];
            if(obj)
               [arrRestaurant addObject:obj];
        }
        
    }
    return  arrRestaurant;
}

@end
