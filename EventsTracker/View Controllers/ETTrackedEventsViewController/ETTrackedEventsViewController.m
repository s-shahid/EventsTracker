//
//  ETTrackedEventsViewController.m
//  EventsTracker
//
//  Created by Mohammed Shahid on 20/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import "ETTrackedEventsViewController.h"

@interface ETTrackedEventsViewController ()

@property (nonatomic, strong) NSSet *eventsSet;

@property (weak, nonatomic) IBOutlet UITableView *trackedEventsTableView;

@end

@implementation ETTrackedEventsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.eventsSet = [DataManager fetchTrackedEventsofUser:[kETUserDefaults userName]];
	
    __weak typeof(self) weakSelf = self;
    
    if (![[self.eventsSet allObjects] count]) {
        [AlertViewManager showAlertViewWithTitle:@"Tracked Events"
                                           style:UIAlertViewStyleDefault
                                         message:@"Please track events to see them here."
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil
                                      controller:nil
                                    alertHandler:^(NSInteger clickedButtonIndex){
                                        [weakSelf.navigationController popViewControllerAnimated:YES];
                                    }];
    }
    
    [self.trackedEventsTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView Delegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[self.eventsSet allObjects] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETEventsCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (!cell) {
        cell = [[ETEventsCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    
    Event *event = [[self.eventsSet allObjects] objectAtIndex:indexPath.row];
    
    cell.eventNameLabel.text = [event valueForKey:kEventName];
    
    cell.eventLocationLabel.text = [event valueForKey:kEventLocation];
    
    cell.eventEntryTypeLabel.text = [event valueForKey:kEventType];
    
    cell.eventThumbnailImageView.image = [UIImage imageNamed:[event valueForKey:kImageURL]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kTrackedEventDetailSegue sender:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - PrepareforSegue Method

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:kTrackedEventDetailSegue]) {
		ETEventDetailViewController *eventDetailController = [segue destinationViewController];
		NSIndexPath *indexPath = [self.trackedEventsTableView indexPathForSelectedRow];
		Event *event = [[self.eventsSet allObjects] objectAtIndex:indexPath.row];
		eventDetailController.eventID = [event valueForKey:kEventID];
	}
}

- (void)viewDidUnload {
	[self setTrackedEventsTableView:nil];
	[super viewDidUnload];
}
@end
