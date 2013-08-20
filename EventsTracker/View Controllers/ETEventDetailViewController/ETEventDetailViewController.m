//
//  ETEventDetailViewController.m
//  EventsTracker
//
//  Created by Mohammed Shahid on 19/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import "ETEventDetailViewController.h"

@interface ETEventDetailViewController ()

@property (nonatomic, strong) Event *event;

@property (nonatomic, strong) NSMutableArray *eventDetailsNameArray;

@property (nonatomic, strong) NSMutableArray *eventDetailsArray;

@property (weak, nonatomic) IBOutlet UITableView *eventDetailTableView;

@end

@implementation ETEventDetailViewController

-(void)awakeFromNib
{
	[super awakeFromNib];
	
	self.eventDetailsArray = [[NSMutableArray alloc] init];
	
	self.eventDetailsNameArray = [[NSMutableArray alloc] initWithObjects:@"Name",@"Location",@"Entry Type", nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *viewControllers = [NSArray arrayWithArray:[self.navigationController viewControllers]];
	
    if ([[viewControllers objectAtIndex:[viewControllers count]-2] isKindOfClass: [ETTrackedEventsViewController class]])
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
	
	self.event = [DataManager fetchEventDetailsForEventWithID:self.eventID];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self parseEventObjectAndAddTableViewHeaderAndFooter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setEventDetailTableView:nil];
    [super viewDidUnload];
}

#pragma mark - Add Table View Header/Footer Views

- (void) addTableViewHeader
{
    UIImageView *eventImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kPadding, kPadding, self.view.frame.size.width - kPadding, 90.0)];
    eventImageView.image = [UIImage imageNamed:[self.event valueForKey:kImageURL]];
    eventImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    UIView *eventView = [[UIView alloc] initWithFrame:CGRectMake(kPadding, kPadding, self.view.frame.size.width, 100.0)];
    [eventView addSubview:eventImageView];
    
    self.eventDetailTableView.tableHeaderView = eventView;
}

- (void) addTableViewFooter
{
    UIButton *addTrackerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addTrackerButton setFrame:CGRectMake(0.0, 5.0, self.view.frame.size.width - 2*kPadding, 44.0)];
	
	NSSet *usersSet = self.event.user;
	int count;
	for (count = 0; count < [[usersSet allObjects] count]; count++) {
		User *user = [[usersSet allObjects] objectAtIndex:count];
		if ([user.userName isEqualToString:[kETUserDefaults userName]]) {
			break;
		}
	}

	(count == [[usersSet allObjects] count])?[self setTitle:kTrackEvent forButton:addTrackerButton]:[self setTitle:kUntrackEvent forButton:addTrackerButton];

	
	[addTrackerButton addTarget:self action:@selector(trackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    UIView *addTrackerView = [[UIView alloc] initWithFrame:CGRectMake(kPadding, kPadding, self.view.frame.size.width, 54.0)];
    [addTrackerView addSubview:addTrackerButton];
        
    self.eventDetailTableView.tableFooterView = addTrackerView;
}

#pragma mark - TableView Delegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.eventDetailsArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kCellIdentifier];
    }
    
    cell.textLabel.text = [self.eventDetailsNameArray objectAtIndex:indexPath.section];
    
    cell.detailTextLabel.text = [self.eventDetailsArray objectAtIndex:indexPath.section];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

#pragma mark - Track Button Pressed

- (IBAction)trackButtonPressed:(UIButton *)sender
{
	if ([sender.titleLabel.text isEqualToString:kTrackEvent]) {
		[self setTitle:kUntrackEvent forButton:sender];
		[DataManager trackEventWithID:self.eventID forUser:[kETUserDefaults userName]];
	}
	else
	{
		[self setTitle:kTrackEvent forButton:sender];
		[DataManager unTrackEventWithID:self.eventID forUser:[kETUserDefaults userName]];
	}
}

#pragma mark - Set Button Title Method

- (void)setTitle:(NSString *)title forButton:(UIButton *)button
{
	[button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateHighlighted];
}

#pragma mark - Parse Event Object

- (void)parseEventObjectAndAddTableViewHeaderAndFooter
{
	if (self.event) {
        
        self.eventDetailTableView.tableHeaderView = nil;
        self.eventDetailTableView.tableFooterView = nil;
        
        [self.eventDetailsArray removeAllObjects];
        
		[self.eventDetailsArray addObject:[self.event valueForKey:kEventName]];
		[self.eventDetailsArray addObject:[self.event valueForKey:kEventLocation]];
		[self.eventDetailsArray addObject:[self.event valueForKey:kEventType]];
		
		[self addTableViewHeader];
		
		[self addTableViewFooter];
	}
}

@end
