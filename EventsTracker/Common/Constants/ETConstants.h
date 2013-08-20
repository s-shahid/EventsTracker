//
//  ETConstants.h
//  EventsTracker
//
//  Created by Mohammed Shahid on 19/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

/*!
 @header       ETConstants
 @abstract     Holds the constants for the app
 @discussion   nil
 */

#ifndef EventsTracker_ETConstants_h
#define EventsTracker_ETConstants_h

#define AlertViewManager [ETAlertViewManager sharedInstance]

#define kStandardUserDefaults [NSUserDefaults standardUserDefaults]

#define kETUserDefaults [ETUserDefaults sharedInstance]

#define DataManager [ETDataManager sharedInstance]

#define SharedCoreData [ETSharedCoreData sharedInstance]

#define kUserName @"userName"

#define kCellIdentifier @"cellIdentifier"

#define kDetailEventSegue @"detailEventSegue"

#define kTrackedEventDetailSegue @"trackedEventDetailSegue"

#define kPadding 10.0

#define kTrackEvent @"Track this Event"

#define kUntrackEvent @"UnTrack this Event"

#define kEventName @"name"

#define kEventLocation @"place"

#define kEventID @"eventID"

#define kEventType @"entryType"

#define kHelveticaNeue @"Helvetica-Neue"

#define kUserEntity @"User"

#define kEventEntity @"Event"

#define kImageURL @"imageURL"

#endif
