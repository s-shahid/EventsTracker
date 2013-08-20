//
//  ETAlertView.h
//  EventsTracker
//
//  Created by Mohammed Shahid on 19/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @class        ETAlertView
 @abstract     Utilities of Alertview class
 @discussion   nil
*/

typedef void (^AlertHandler)(NSInteger clickedButtonIndex);

@interface ETAlertView : UIAlertView

@property (nonatomic, strong) AlertHandler alertHandler;

@end
