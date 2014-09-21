//
//  Global.h
//  SOS APP
//
//  Created by danglv.hut@gmail.com on 9/1/13.
//  Copyright (c) 2013 danglv.hut@gmail.com. All rights reserved.
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

//=========================GLOBAL VALUE=========================//

extern NSString *gMemberId;
extern BOOL gIsLogin;
extern BOOL gIsHasNetwork;







