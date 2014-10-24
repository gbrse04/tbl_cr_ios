//
//  Config.h
//  SOS APP
//
//  Created by Mr.Lemon on 9/4/13.
//  Copyright (c) 2013 TableCross.hut@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+Colours.h"

@interface Config : NSObject



//==================APP ACCOUNT CONFIG======================//
#define kAppNameManager @"テーブルクロス"
#define kUrlApp @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=722629966"

#define kUrlAppStore @"https://itunes.apple.com/app/id722629966"


//===================WEBSERVICE CONFIG======================//

#define kBaseUrl @"http://tablecross.jp:8081/client-api/"

#define kUrlLogin @"login"
#define kUrlRegister @"register"
#define kUrlLogout @"logout"
#define kUrlChangePass @"changePassword"
#define kUrlGetListArea @"getAreas"
#define kUrlGetUserInfo @"getUserInfo"
#define kUrlUpdateProfile @"updateUser"
#define kUrlSearchRestaurant @"searchRestaurant"
#define kUrlGetListNotification @"getNotifyList"
#define kUrlGetUnpushNotification @"getNotifyUnPushList"
#define kUrlGetRestaurantDetail @"getRestaurantInfo"
#define kUrlGetShareLink @"getShareLinkApp"
#define kUrlSendOrder @"order"
#define kUrlGetRestaurantByCategoryId @"getCategoryList"


#define kMessageLoginRequired @"この機能を利用するため、ログインが必要です。ログインしますか。"


//Refresh GridView

#define kLastUpdate @"Last update : %@"
#define kPullToRefresh @"Pull down to refresh..."
#define kReleaseToRefresh @"Release to update..."
#define kLoading @"Loading..."


#define NUMBER_RECORD_PER_PAGE 10
#define TIME_REFRESH 20

//=================FORMAT CONFIG=======================//

#define kDateFormat  @"dd/MM/yyyy à hh:mm"

//==================COLOR CONFIG=======================//

#define kColorViolet [UIColor colorFromHexString:@"#660057"]
#define kColorGrayBackground [UIColor colorFromHexString:@"#E9E9E9"]
#define kColorTextWhite [UIColor colorFromHexString:@"#FFFFFF"]
#define kColorTextGray [UIColor colorFromHexString:@"#444446"]
#define kColorBgMenu [UIColor colorFromHexString:@"#58585A"]

#define  kColorOrange  [UIColor colorWithRed:228.0/255.0 green:142.0f/255.0 blue:7.0f/255.0 alpha:1]


// KEY CONFIG
#define  KEY_AREAID @"KEY_AREAID"
#define  KEY_NAME_KANJI @"KEY_NAME_KANJI"
#define  KEY_AREA_NAME @"KEY_AREA_NAME"
#define  KEY_EMAIL @"KEY_EMAIL"
#define  KEY_PASSWORD @"KEY_PASSWORD"
#define  KEY_NAME @"KEY_NAME"
#define  KEY_PHONE @"KEY_PHONE"
#define  KEY_BIRTHDAY @"KEY_BIRTHDAY"
#define  KEY_SHARELINK @"KEY_SHARELINK"
#define  KEY_POINT @"KEY_POINT"
#define  KEY_TOTAL_MEAL @"orderCount"
#define  KEY_TOTAL_MEAL_VIAAPP @"totalOrder"
#define  KEY_TOTAL_SHARE @"totalUserShare"
#define  KEY_USER_ID @"KEY_USER_ID"
#define  KEY_USER_ID_PROFILE @"KEY_USER_ID_PROFILE"
#define  KEY_LOGIN_TYPE @"LOGIN_TYPE"
#define  KEY_SESSION_ID @"KEY_SESSION_ID"

#define  KEY_NOTIF_SETTING_1 @"KEY_NOTIF_SETTING_1"
#define  KEY_NOTIF_SETTING_2 @"KEY_NOTIF_SETTING_2"
#define  KEY_NOTIF_SETTING_3 @"KEY_NOTIF_SETTING_3"

#define  NOTIF_LOGOUT @"KEY_NOTIF_LOGOUT"


#define  NOTIFY_TYPE_BEFORE_DATE @"NOTIFY_TYPE_BEFORE_DATE"

#define  NOTIFY_TYPE_NEWS @"NOTIFY_TYPE_NEWS"

#define  NOTIFY_TYPE_ORDER_SUCCESS @"NOTIFY_TYPE_ORDER_SUCCESS"

#define  NOTIFY_TYPE_REGISTER @"NOTIFY_TYPE_REGISTER"
#define  NOTIFY_RELOAD_NOTIFICATION @"NOTIFY_RELOAD_NOTIFICATION"


#pragma mark - Languagee

#define msg_confirm_logout          @"本当によろしいですか。"
#define msg_invalid_email           @"メールアドレスが違います。"
#define msg_input_required_field    @"要求されたフィールドを入力してください。"
#define msg_change_pass_sucess      @"パスワードが変更されました。"
#define msg_password_notmatch       @"パスワードと確認パスワードが一致しません。"
#define msg_not_support_call        @"あなたのデバイスはこの機能をサポートしません。"
#define msg_no_result               @"検索結果が見つかりません。"
#define  title_error                @"エラー"
#define title_logout                @"ログアウト"

#define btn_cancel                  @"キャンセル"

#define msg_login_facebook_error    @"フェースブックログインエラー"


@end
