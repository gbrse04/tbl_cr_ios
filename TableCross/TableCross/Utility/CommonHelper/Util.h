//
//  Util.h
//
//
//  Created by Dang Luu on 12/9/13.
//  Copyright 2011 TableCross.hut@gmail.com., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "RestaurantObj.h"


@interface Util : NSObject
@property (strong, nonatomic) MBProgressHUD *progressView;

+(CGFloat)getheightRowForRestaurant:(RestaurantObj*)obj isShowDescription:(BOOL)isShowDescription;

+(CGFloat)getHeightForText:(NSString*)dict andHeight:(CGFloat)height andFont:(UIFont*)font;

+(void)SetTitleForArrayButton:(NSString*)textValue andArray:(NSMutableArray*)arrButton;


+ (Util *)sharedUtil;
//+ (AppDelegate *)appDelegate;
+(BOOL)isConnectNetwork;

+(NSString*)getUDID;

+(NSMutableArray*)getRecentSearch;
+(void)storeRecentSearch:(NSMutableArray*)data;


+ (void)showError:(NSDictionary*)dict;

//Auto dismiss alert
+(void)showAutoDismissAlert:(NSString*)message title:(NSString*)string time:(NSInteger)timeToDismiss;

//Alert functions
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title;


+ (void)showMessage:(NSString *)message withTitle:(NSString *)title andDelegate:(id)delegate;
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title delegate:(id)delegate andTag:(NSInteger)tag;
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherTitle delegate:(id)delegate andTag:(NSInteger)tag;

//Date functions
+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)dateFormat;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)dateFormat;
+ (NSString *)stringFromDateString:(NSString *)dateString;
+ (NSDate*)convertTwitterDateToNSDate:(NSString*)created_at;
+ (NSString *)stringFromDateRelative:(NSDate*)date;

//Loading view functions
- (void)showLoadingView;
- (void)showLoadingViewWithTitle:(NSString *)title;
- (void)hideLoadingView;

//NSUserDefaults functions
+ (void)setValue:(id)value forKey:(NSString *)key;
+ (void)setBoolValue:(BOOL)value forKey:(NSString *)key;
+ (BOOL)getBoolValueForKey:(NSString *)key;
+ (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
+ (void)setValue:(id)value forKeyPath:(NSString *)keyPath;
+ (void)setObject:(id)obj forKey:(NSString *)key;
+ (id)valueForKey:(NSString *)key;
+ (id)valueForKeyPath:(NSString *)keyPath;
+ (id)objectForKey:(NSString *)key;
+ (void)removeObjectForKey:(NSString *)key;

//JSON functions
+ (id)convertJSONToObject:(NSString*)str;
+ (NSString *)convertObjectToJSON:(id)obj;
+ (NSString *)convertDictionaryToString:(NSDictionary*)dict;
+ (id)getJSONObjectFromFile:(NSString *)file;

//Other stuff
//+ (NSString *)getXIB:(Class)fromClass;

+ (UIImage *)imageWithUIView:(UIView *)view;

+(BOOL)isValidEmail:(NSString*)emailAddress;

//Slide view animation

+(void)moveUp:(UIView*)view offset:(float)offset;
+(void)moveDow:(UIView*)view offset:(float)offset;
+(void)moveRight:(UIView*)view offset:(float)offset;
+(void)moveLeft:(UIView*)view offset:(float)offset;

@end
