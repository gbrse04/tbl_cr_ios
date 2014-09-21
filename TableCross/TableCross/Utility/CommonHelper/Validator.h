//
//  Validator.h
//  SetaBase
//
//  Created by Dang Luu on 3/11/13.
//  Copyright (c) 2013 Setacinq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validator : NSObject

+ (Validator *)sharedInstance;

+ (BOOL)validateEmail:(NSString*)email;
+ (BOOL)validateUrl:(NSString *)candidate;

+ (NSString *)getString:(NSInteger)i;
+ (NSNumber *)getSafeInt:(id)obj;
+ (NSNumber *)getSafeFloat:(id)obj;
+ (NSNumber *)getSafeBool:(id)obj;
+ (NSString *)getSafeString:(id)obj;
+ (BOOL)isNullOrNilObject:(id)object;
+ (BOOL)isValidObject:(id)object;

@end
