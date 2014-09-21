//
//  APIClient.m
//  TableCross
//
//  Created by DangLV on 9/18/14.
//  Copyright (c) 2014 Lemon. All rights reserved.
//


#import "AFNetworking.h"
#import "APIClient.h"

static NSString * const BASE_URL = @"http://api.thethao247.vn/";

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
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}


//+ (void)getNewsInCategory:(NSString *)categoryId page:(NSString *)page pageSize:(NSString *)pageSize success:(TTResponseSuccess)success failure:(TTResponseFailure)failure {
//    [[TheThao247APIClient sharedClient] getPath:NEWS_CATEGORY parameters:@{@"cat_id": categoryId, @"page": page, @"pagesize": pageSize} success:success failure:failure];
//}

@end
