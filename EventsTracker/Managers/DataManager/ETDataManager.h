//
//  ETDataManager.h
//  EventsTracker
//
//  Created by Mohammed Shahid on 20/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class        ETDataManager
 @abstract     Utilities of Coredata operations
 @discussion   nil
*/

@interface ETDataManager : NSObject

/*!
 @method       sharedInstance
 @abstract     Creates shared instance for coredata
 @discussion   nil
*/

+ (id) sharedInstance;

/*!
 @method       fetchEvents
 @abstract     Return the Fetched Events
 @discussion   nil
*/

-(NSMutableArray *)fetchEvents;

/*!
 @method       fetchTrackedEventsofUser
 @abstract     Return the NSSet of Tracked Events of user
 @discussion   nil
*/

-(NSSet *)fetchTrackedEventsofUser:(NSString *)userName;


/*!
 @method       fetchEventDetailsForEventWithID
 @abstract     Return the Event object of Tracked Events of eventID
 @discussion   nil
*/

- (Event *) fetchEventDetailsForEventWithID:(NSString *)eventID;

/*!
 @method       trackEventWithID
 @abstract     trackEvent action for user
 @discussion   nil
*/

- (void)trackEventWithID:(NSString *)eventID forUser:(NSString *)userName;

/*!
 @method       unTrackEventWithID
 @abstract     UntrackEvent action for user
 @discussion   nil
*/

- (void)unTrackEventWithID:(NSString *)eventID forUser:(NSString *)userName;

/*!
 @method       addUserWithName
 @abstract     addUser
 @discussion   nil
*/

- (void) addUserWithName:(NSString *)userName;

/*!
 @method       lookUpForUserWithName
 @abstract     To look up whether user is present in user entity
 @discussion   nil
*/

- (User *) lookUpForUserWithName:(NSString *)userName;

/*!
 @method       lookUpForEventWithID
 @abstract     To look up whether event is present in event entity
 @discussion   nil
 */

- (Event *) lookUpForEventWithID:(NSString *)eventID;

@end
