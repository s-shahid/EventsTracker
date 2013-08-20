//
//  ETUserDefaults.h
//  EventsTracker
//
//  Created by Mohammed Shahid on 19/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class        ETUserDefaults
 @abstract     Utilities for handling Userdefaults
 @discussion   nil
*/

@interface ETUserDefaults : NSObject

/*!
 @method       sharedInstance
 @abstract     Creates shared instance for UserDefaults
 @discussion   nil
*/

+ (id) sharedInstance;

- (void) setUserName:(NSString *)userName;

- (void) removeUserName;

- (NSString *)userName;

@end
