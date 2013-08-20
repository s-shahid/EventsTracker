//
//  ETUserDefaults.m
//  EventsTracker
//
//  Created by Mohammed Shahid on 19/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import "ETUserDefaults.h"

@implementation ETUserDefaults

+ (id) sharedInstance
{
    static ETUserDefaults *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ETUserDefaults alloc] init];
    });
    return sharedInstance;
}


- (void) setUserName:(NSString *)userName
{
    [kStandardUserDefaults setObject:userName forKey:kUserName];
    [kStandardUserDefaults synchronize];
}

- (NSString *)userName
{
    return [kStandardUserDefaults objectForKey:kUserName];
}

- (void) removeUserName
{
    [kStandardUserDefaults removeObjectForKey:kUserName];
    [kStandardUserDefaults synchronize];
}

@end
