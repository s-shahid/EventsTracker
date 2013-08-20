//
//  ETEventDetailViewController.h
//  EventsTracker
//
//  Created by Mohammed Shahid on 19/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETTrackedEventsViewController.h"

/*!
 @class        ETEventDetailViewController
 @abstract     Shows the Details of the Event
 @discussion   nil
*/

@interface ETEventDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSString *eventID;

@end
