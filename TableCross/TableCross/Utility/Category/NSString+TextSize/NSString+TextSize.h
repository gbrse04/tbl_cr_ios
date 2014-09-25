//
//  NSString+TextSize.h
//  TableCross
//
//  Created by Lemon on 9/26/14.
//  Copyright (c) 2014 Lemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TextSize)

-(float)heightOfTextViewToFitWithFont:(UIFont*)font andWidth:(float)width;
-(NSString*)stringByAddingSpace:(NSString*)stringToAddSpace spaceCount:(NSInteger)spaceCount atIndex:(NSInteger)index;
@end
