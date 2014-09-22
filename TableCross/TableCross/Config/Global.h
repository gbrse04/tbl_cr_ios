//
//  Global.h
//  SOS APP
//
//  Created by TableCross.hut@gmail.com on 9/1/13.
//  Copyright (c) 2013 TableCross.hut@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"

typedef  enum {
    SearchByCondition,
    SearchByLocation,
    SearchByCC,
    SearchHistory,
    
} SearchType;

#define COLOR_ACTIVE [UIColor whiteColor]
#define COLOR_INACTIVE [UIColor whiteColor]

#define SHOW_POUP_NETWORK  [Util showMessage:@"No internet connection.Please enable network and try again !" withTitle:@"Error"];

//=========================GLOBAL VALUE=========================//
extern UINavigationController  *gNavigationViewController;
extern NSString *gMemberId;
extern BOOL gIsLogin;
extern BOOL gIsLoginFacebook;
extern BOOL gIsHasNetwork;

extern NSString *shareAppMessage;
extern NSString *shareAppUrl;

extern double gCurrentLatitude;
extern double gCurrentLongitude;

extern BOOL gIsEnableLocation;









