//
//  ETEventsCustomCell.h
//  EventsTracker
//
//  Created by Mohammed Shahid on 20/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @class        ETEventsCustomCell
 @abstract     Custom cell for three labels and thumbail icon
 @discussion   nil
*/

@interface ETEventsCustomCell : UITableViewCell

@property (nonatomic, strong) UILabel *eventNameLabel;

@property (nonatomic, strong) UILabel *eventLocationLabel;

@property (nonatomic, strong) UILabel *eventEntryTypeLabel;

@property (nonatomic, strong) UIImageView *eventThumbnailImageView;

@end
