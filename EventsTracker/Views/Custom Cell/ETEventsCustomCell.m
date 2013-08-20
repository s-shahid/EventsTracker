//
//  ETEventsCustomCell.m
//  EventsTracker
//
//  Created by Mohammed Shahid on 20/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import "ETEventsCustomCell.h"

@implementation ETEventsCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addCustomViews];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self addCustomViews];
}

- (void) addCustomViews
{
    self.eventNameLabel = [[UILabel alloc] init];
    [self.eventNameLabel setFont:[UIFont fontWithName:kHelveticaNeue size:16.0]];
    [self.eventNameLabel setTextColor:[UIColor blackColor]];
    [self.eventNameLabel setBackgroundColor:[UIColor clearColor]];

    self.eventLocationLabel = [[UILabel alloc] init];
    [self.eventLocationLabel setFont:[UIFont fontWithName:kHelveticaNeue size:14.0]];
    [self.eventLocationLabel setTextColor:[UIColor darkGrayColor]];
    [self.eventLocationLabel setBackgroundColor:[UIColor clearColor]];

    self.eventEntryTypeLabel = [[UILabel alloc] init];
    [self.eventEntryTypeLabel setFont:[UIFont fontWithName:kHelveticaNeue size:12.0]];
    [self.eventEntryTypeLabel setTextColor:[UIColor lightGrayColor]];
    [self.eventEntryTypeLabel setBackgroundColor:[UIColor clearColor]];

    self.eventThumbnailImageView = [[UIImageView alloc] init];
    [self.eventThumbnailImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.eventThumbnailImageView setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:self.eventNameLabel];
    [self addSubview:self.eventLocationLabel];
    [self addSubview:self.eventEntryTypeLabel];
    [self addSubview:self.eventThumbnailImageView];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.eventThumbnailImageView setFrame:CGRectMake(kPadding, kPadding, 5*kPadding, 8*kPadding)];
    
    [self.eventNameLabel setFrame:CGRectMake(self.eventThumbnailImageView.frame.size.width + 2*kPadding, kPadding, self.frame.size.width - self.eventThumbnailImageView.frame.size.width - 5*kPadding, 2*kPadding)];
    
    [self.eventLocationLabel setFrame:CGRectMake(self.eventThumbnailImageView.frame.size.width + 2*kPadding, self.eventNameLabel.frame.size.height + 2*kPadding, self.frame.size.width - self.eventThumbnailImageView.frame.size.width - 5*kPadding, 2*kPadding)];
    
    [self.eventEntryTypeLabel setFrame:CGRectMake(self.eventThumbnailImageView.frame.size.width + 2*kPadding, self.eventNameLabel.frame.size.height + self.eventLocationLabel.frame.size.height + 3*kPadding, self.frame.size.width - self.eventThumbnailImageView.frame.size.width - 5*kPadding, 2*kPadding)];
}

@end
