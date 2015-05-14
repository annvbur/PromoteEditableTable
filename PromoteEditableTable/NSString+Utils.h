//  NSString(Utils).h
//  
//  waverleysoftware.com
//
//  Created by Alyona Bachurina on 4/19/15.
//  Copyright (c) 2014 waverleysoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet;

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;

-(BOOL)validateEmail;

-(BOOL)validateWithRegexp:(NSString*)regexpString;

@end