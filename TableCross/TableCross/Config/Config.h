//
//  Config.h
//  SOS APP
//
//  Created by Mr.Lemon on 9/4/13.
//  Copyright (c) 2013 danglv.hut@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+Colours.h"

@interface Config : NSObject



//==================APP ACCOUNT CONFIG======================//
#define kAppNameManager @"Eat Sushi"
#define kUrlApp @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=722629966"

#define kUrlAppStore @"https://itunes.apple.com/app/id722629966"


//===================WEBSERVICE CONFIG======================//

#define kBaseUrl @"http://track.rimonit.com/"

#define kUrlLogin @"api_userInfo.php"
#define kUrlSendLocation @"api_call.php"


//Refresh GridView

#define kLastUpdate @"Last update : %@"
#define kPullToRefresh @"Pull down to refresh..."
#define kReleaseToRefresh @"Release to update..."
#define kLoading @"Loading..."


//=================FORMAT CONFIG=======================//

#define kDateFormat  @"dd/MM/yyyy à hh:mm"

//==================COLOR CONFIG=======================//

#define kColorViolet [UIColor colorFromHexString:@"#660057"]
#define kColorGrayBackground [UIColor colorFromHexString:@"#E9E9E9"]
#define kColorTextWhite [UIColor colorFromHexString:@"#FFFFFF"]
#define kColorTextGray [UIColor colorFromHexString:@"#444446"]
#define kColorBgMenu [UIColor colorFromHexString:@"#58585A"]

#define  kColorOrange  [UIColor colorWithRed:228.0/255.0 green:142.0f/255.0 blue:7.0f/255.0 alpha:1]


@end
