//
//  Util.m
//
//
//  Created by Dang Luu on 12/1/11.
//  Copyright 2011 TableCross.hut@gmail.com., Ltd. All rights reserved.
//

#import "Util.h"
//#import "NSString+Extension.h"
#import "NSDate+Additions.h"
#import "Macros.h"
#import "SSKeychain.h"

#define kCalendarType NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit | NSWeekOfMonthCalendarUnit | NSWeekOfYearCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSTimeZoneCalendarUnit

@implementation Util

+(CGFloat)getHeightForText:(NSString*)string andHeight:(CGFloat)width  andFont:(UIFont*)font {
    
    
    if(IS_IOS7) {
        CGRect frame = [string boundingRectWithSize:CGSizeMake(width,1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
     CGFloat height =   frame.size.height;
        return height;
    }
    else
    {
        CGSize maximumSize = CGSizeMake(width, 9999);
        CGSize myStringSize = [string sizeWithFont:font
                                   constrainedToSize:maximumSize
                                       lineBreakMode:NSLineBreakByWordWrapping];
        
        return  myStringSize.height;
    }
    
}

+(void)SetTitleForArrayButton:(NSString*)textValue andArray:(NSMutableArray*)arrButton {
  
    
    for (UIButton *btn in arrButton) {
        [btn setTitle:@"0" forState:UIControlStateNormal];
    }

    NSInteger  offsetIndex = [arrButton count] -[textValue length];
    for (NSInteger i=([textValue length]-1); i>=0; i--) {
        if(i<[arrButton count])
        {
            [((UIButton*)[arrButton objectAtIndex:i+offsetIndex]) setTitle:[NSString stringWithFormat:@"%C",[textValue characterAtIndex:i]] forState:UIControlStateNormal];
        }
    }
}

+ (Util *)sharedUtil {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (void)dealloc {
    self.progressView = nil;
    [super dealloc];
}

+ (AppDelegate *)appDelegate {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate;
}
+(NSString*)getUDID {
    
    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    NSString *strApplicationUUID = [SSKeychain passwordForService:appName account:@"tablecross"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SSKeychain setPassword:strApplicationUUID forService:appName account:@"tablecross"];
    }
    
    return strApplicationUUID;

}

+(NSMutableArray*)getRecentSearch {

   NSString *recent = [self valueForKey:@"SEARCH_HISTORY"];
    return [NSMutableArray arrayWithArray: [recent componentsSeparatedByString:@","]];
    
}
+(void)storeRecentSearch:(NSMutableArray*)data{
    
    
    NSString *recent = [data componentsJoinedByString:@","];
    
    [self setValue:recent forKey:@"SEARCH_HISTORY"];
    
    
}


+(BOOL)isConnectNetwork{
    
    NSString *urlString = @"http://www.google.com/";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"HEAD"];
    NSHTTPURLResponse *response;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: NULL];
    
    return ([response statusCode] == 200) ? YES : NO;
    
}
+ (void)showError:(NSDictionary*)dict {
    
    NSInteger errorCode = [[dict objectForKey:@"errorCode"] integerValue];
    
//    switch (errorCode) {
//        case 0:
//            [self showMessage:@"Email not exist" withTitle:title_error];
//            break;
//        case 2:
//            [self showMessage:@"User not login" withTitle:title_error];
//            break;
//
//        case 3:
//            [self showMessage:@"Old password invalid" withTitle:title_error];
//            break;
//
//        case 4:
//            [self showMessage:@"New password invalid" withTitle:title_error];
//            break;
//
//        case 5:
//            [self showMessage:@"UserId not exist" withTitle:title_error];
//            break;
//        case 6:
//            [self showMessage:@"Invalid params" withTitle:title_error];
//            break;
//
//        case 7:
//            [self showMessage:@"Email already exist" withTitle:title_error];
//            break;
//
//        case 8:
//            [self showMessage:@"Wrong password" withTitle:title_error];
//            break;
//        case 99:
//            [self showMessage:@"System error" withTitle:title_error];
//            break;
//
//        default:
//            break;
//    }
    
    
    [self showMessage:[dict objectForKey:@"errorMess"] withTitle:title_error];
}
#pragma mark Auto Dismiss alert
+(void)showAutoDismissAlert:(NSString*)message title:(NSString*)string time:(NSInteger)timeToDismiss{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kAppNameManager message:message delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alertView show];
    
//    UIImageView *tickImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    tickImageView.center = CGPointMake(alertView.bounds.size.width/2, alertView.bounds.size.height - 45);
//    tickImageView.image = [UIImage imageNamed:@"checkmark.png"];
//    [alertView addSubview:tickImageView];
//    [tickImageView release];
    
    [self performSelector:@selector(dismissAlert:) withObject:alertView afterDelay:2];
//    [alertView release];
    
}
+ (void)dismissAlert:(UIAlertView *)alertView
{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark Alert functions
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}

+ (void)showMessage:(NSString *)message withTitle:(NSString *)title andDelegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
    [alert release];
}

+ (void)showMessage:(NSString *)message withTitle:(NSString *)title delegate:(id)delegate andTag:(NSInteger)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alert.tag = tag;
    [alert show];
    [alert release];
}

+ (void)showMessage:(NSString *)message withTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherTitle delegate:(id)delegate andTag:(NSInteger)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    alert.tag = tag;
    alert.delegate = delegate;
    [alert show];
    [alert release];
}

#pragma mark Date functions
+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [formatter setDateFormat:dateFormat];
    NSDate *ret = [formatter dateFromString:dateString];
    [formatter release];
    return ret;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSString *ret = [formatter stringFromDate:date];
    [formatter release];
    return ret;
}

+ (NSString *)stringFromDateString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *utcDate = [formatter dateFromString:dateString];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    [formatter setDateFormat:@"MM/dd/yyyy h:mm a"];
    return [formatter stringFromDate:utcDate];
}

+ (NSDate*)convertTwitterDateToNSDate:(NSString*)created_at
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE LLL d HH:mm:ss Z yyyy"];
	[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"US"]];
	
	NSDate *convertedDate = [dateFormatter dateFromString:created_at];
	[dateFormatter release];
	
    return convertedDate;
}

+ (NSString *)stringFromDateRelative:(NSDate*)date {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setDateStyle: NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle: NSDateFormatterShortStyle];
	[dateFormatter setDoesRelativeDateFormatting:YES];
	
	NSString *result = [dateFormatter stringFromDate:date];
	
	return result;
}

#pragma mark Loading View
- (MBProgressHUD *)progressView
{
    if (!_progressView) {
        _progressView = [[MBProgressHUD alloc] initWithView:[Util appDelegate].window];
        _progressView.animationType = MBProgressHUDAnimationFade;
        _progressView.dimBackground = NO;
		[[Util appDelegate].window addSubview:_progressView];
    }
    return _progressView;
}

- (void)showLoadingView {
    [self hideLoadingView];
    [self showLoadingViewWithTitle:@""];
}

- (void)showLoadingViewWithTitle:(NSString *)title
{
    [self hideLoadingView];
    self.progressView.labelText = title;
    [self.progressView show:NO];
}

- (void)hideLoadingView {
    [self.progressView hide:NO];
}

#pragma mark NSUserDefaults functions
+ (void)setValue:(id)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setBoolValue:(BOOL)value forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getBoolValueForKey:(NSString *)key {
    
   return [[NSUserDefaults standardUserDefaults] boolForKey:key];
    
}

+ (void)setValue:(id)value forKeyPath:(NSString *)keyPath
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKeyPath:keyPath];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setObject:(id)obj forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)valueForKey:(NSString *)key
{
    
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

+ (id)valueForKeyPath:(NSString *)keyPath
{
    return [[NSUserDefaults standardUserDefaults] valueForKeyPath:keyPath];
}

+ (id)objectForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)removeObjectForKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark JSON functions
+ (id)convertJSONToObject:(NSString*)str {
    
	NSError *error = nil;
	NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
	NSDictionary *responseDict;
	
	if (data) {
		responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
	} else {
		responseDict = nil;
	}
	
	return responseDict;
}

+(NSString*)convertDictionaryToString:(NSDictionary*)dict{
    NSError* error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:0
                                                         error:&error];
    NSString *jsonString=@"";
    if (!jsonData) {
        NSLog(@"Error %@", error);
    } else {
        jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        //NSLog(@&quot;JSON OUTPUT: %@&quot;,JSONString);
    }
    return jsonString;
}

+ (NSString *)convertObjectToJSON:(id)obj {
    
    NSError *error = nil;
	NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
	
	if (error) {
		return @"";
	}
	return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
}

+ (id)getJSONObjectFromFile:(NSString *)file {
	NSString *textPAth = [[NSBundle mainBundle] pathForResource:file ofType:@"json"];
	
    NSError *error;
    NSString *content = [NSString stringWithContentsOfFile:textPAth encoding:NSUTF8StringEncoding error:&error];  //error checking omitted
	
	id returnData = [Util convertJSONToObject:content];
	return returnData;
}

#pragma mark Other stuff
//+ (NSString *)getXIB:(Class)fromClass
//{
//	NSString *className = NSStringFromClass(fromClass);
//
//    if (IS_IPAD()) {
//		className = [className stringByAppendingString:IPAD_XIB_POSTFIX];
//	} else {
//
//	}
//	return className;
//}

+ (UIImage *)imageWithUIView:(UIView *)view
{
    CGSize screenShotSize = view.bounds.size;
	
	UIGraphicsBeginImageContext(screenShotSize);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
	
    [view.layer renderInContext:contextRef];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
    // return the image
    return img;
}


-(void)slideUpView:(UIView*)view offset:(CGFloat)offset{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = view.frame;
    rect.origin.y -= offset;
    rect.size.height += offset;
    view.frame = rect;
    
    [UIView commitAnimations];
}
-(void)slideDownView:(UIView*)view offset:(CGFloat)offset
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = view.frame;
    rect.origin.y += offset;
    rect.size.height -= offset;
    view.frame = rect;
    [UIView commitAnimations];
    
}


#pragma mark UTILITY FUNCTIONS

+(BOOL)isValidEmail:(NSString*)emailAddress
{
    
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailAddress];
}



#pragma mark  - UIView Moving Utils
+(void)moveUp:(UIView*)view offset:(float)offset{
    view.frame=CGRectMake(view.frame.origin.x, view.frame.origin.y-offset, view.frame.size.width, view.frame.size.height);
}
+(void)moveDow:(UIView*)view offset:(float)offset{
    view.frame=CGRectMake(view.frame.origin.x, view.frame.origin.y+offset, view.frame.size.width, view.frame.size.height);
}
+(void)moveRight:(UIView*)view offset:(float)offset{
    view.frame=CGRectMake(view.frame.origin.x+offset, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
}
+(void)moveLeft:(UIView*)view offset:(float)offset{
    view.frame=CGRectMake(view.frame.origin.x-offset, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
}


@end
