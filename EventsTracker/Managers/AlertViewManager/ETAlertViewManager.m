//
//  ETAlertViewManager.m
//  EventsTracker
//
//  Created by Mohammed Shahid on 19/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import "ETAlertViewManager.h"

@implementation ETAlertViewManager
{
    ETAlertView *alertViewShared;
}

+ (id) sharedInstance
{
	static ETAlertViewManager *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[ETAlertViewManager alloc] init];
	});
	return sharedInstance;
}

- (void) showAlertViewWithTitle:(NSString *)title
                          style:(UIAlertViewStyle)alertStyle
						message:(NSString *)message
			  cancelButtonTitle:(NSString *)cancelButtonTitle
			  otherButtonTitles:(NSArray *)otherButtonTitles
                     controller:(UIViewController *)viewController
                   alertHandler:(AlertHandler)alertHandlerBlock
{
	alertViewShared = [[ETAlertView alloc] initWithTitle:title
														message:message
													   delegate:self
											  cancelButtonTitle:cancelButtonTitle
											  otherButtonTitles:nil];
    
    alertViewShared.alertViewStyle = alertStyle;
    
    if (alertStyle == UIAlertViewStylePlainTextInput) {
        [[alertViewShared textFieldAtIndex:0] setDelegate:(id)viewController];
    }
    
	for (NSString *title in otherButtonTitles) {
		[alertViewShared addButtonWithTitle:title];
	}
	
	alertViewShared.alertHandler = alertHandlerBlock;
	
	[alertViewShared show];
}

-(void)dismissAlertView
{
    [alertViewShared dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark - AlertView Delegate Method

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput) {
        if (((ETAlertView *)alertView).alertHandler && ![[[alertView textFieldAtIndex:0] text] isEqualToString:@""]) {
			
			NSString *userName = [alertView textFieldAtIndex:0].text;
			
            [kETUserDefaults setUserName:[userName lowercaseString]];
			[DataManager addUserWithName:[userName lowercaseString]];
            ((ETAlertView *)alertView).alertHandler(buttonIndex);
        }
    }
	else
    {
        if (((ETAlertView *)alertView).alertHandler) {
            ((ETAlertView *)alertView).alertHandler(buttonIndex);
        }
    }
    
}

@end
