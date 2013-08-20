//
//  ETAlertViewManager.h
//  EventsTracker
//
//  Created by Mohammed Shahid on 19/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETAlertView.h"

/*!
 @class        ETAlertViewManager
 @abstract     Utilities for handling UIAlertView
 @discussion   nil
*/

@interface ETAlertViewManager : NSObject

/*!
 @method       sharedInstance
 @abstract     Creates shared instance for AlertView
 @discussion   nil
 */

+ (id) sharedInstance;

/*!
 @method       showAlertViewWithTitle
 @abstract     Creates and shows the alertview instance
 @discussion   nil
 */

- (void) showAlertViewWithTitle:(NSString *)title
                          style:(UIAlertViewStyle)alertStyle
						message:(NSString *)message
			  cancelButtonTitle:(NSString *)cancelButtonTitle
			  otherButtonTitles:(NSArray *)otherButtonTitles
                     controller: (UIViewController *)viewController
				   alertHandler:(AlertHandler)alertHandlerBlock;

/*!
 @method       dismissAlertView
 @abstract     dismisses the alertview
 @discussion   nil
*/

-(void) dismissAlertView;


@end
