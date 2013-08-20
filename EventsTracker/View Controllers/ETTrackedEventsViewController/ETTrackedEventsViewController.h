//
//  ETTrackedEventsViewController.h
//  EventsTracker
//
//  Created by Mohammed Shahid on 20/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ETEventsCustomCell.h"
#import "ETEventDetailViewController.h"

/*!
 @class        ETTrackedEventsViewController
 @abstract     Shows the Tracked Events of the current user
 @discussion   nil
*/

@interface ETTrackedEventsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@end
