//  NSString(Utils).m
//  
//  waverleysoftware.com
//
//  Created by Alyona Bachurina on 4/19/15.
//  Copyright (c) 2014 waverleysoftware.com. All rights reserved.
//

#import "NSString+Utils.h"


@implementation NSString (Utils)


- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange rangeOfFirstWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]];
    if (rangeOfFirstWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringFromIndex:rangeOfFirstWantedCharacter.location];
}

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange rangeOfLastWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]
                                                               options:NSBackwardsSearch];
    if (rangeOfLastWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringToIndex:rangeOfLastWantedCharacter.location+1]; // non-inclusive
}

- (BOOL)validateEmail
{
   //NSString *regexpString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
   //NSPredicate *regexp = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexpString];

   NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
   NSString *text = [self stringByTrimmingLeadingCharactersInSet:set];
   text = [text stringByTrimmingTrailingCharactersInSet:set];

   //BOOL result = [regexp evaluateWithObject:text];

    BOOL result = [text validateWithRegexp:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"];

   return result;

}

-(BOOL)validateWithRegexp:(NSString*)regexpString{
    NSPredicate *regexp = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexpString];
    BOOL result = [regexp evaluateWithObject:self];
    return result;
}

@end