//
//  ETViewController.m
//  EventsTracker
//
//  Created by Mohammed Shahid on 19/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import "ETViewController.h"

@interface ETViewController ()

@property (weak, nonatomic) IBOutlet UITableView *eventsTableView;

@property (nonatomic, strong) NSMutableArray *eventsArray;

@end

@implementation ETViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	__weak typeof(self) weakSelf = self;
    
    [AlertViewManager showAlertViewWithTitle:@"Username"
                                       style:UIAlertViewStylePlainTextInput
                                     message:@"Enter the username"
                           cancelButtonTitle:nil
                           otherButtonTitles:@[@"OK"]
                                 controller :self
                                alertHandler:^(NSInteger clickedButtonIndex){
                                    if ([kETUserDefaults userName]) {
                                        
                                        weakSelf.eventsArray = [DataManager fetchEvents];
                                        
                                        [weakSelf.eventsTableView setDelegate:self];
                                        [weakSelf.eventsTableView setDataSource:self];
                                        
                                        [weakSelf.eventsTableView reloadData];
                                    }
                                }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setEventsTableView:nil];
    [super viewDidUnload];
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
    return [self.eventsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETEventsCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (!cell) {
        cell = [[ETEventsCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    
    Event *event = [self.eventsArray objectAtIndex:indexPath.row];
    
    cell.eventNameLabel.text = [event valueForKey:kEventName];
    
    cell.eventLocationLabel.text = [event valueForKey:kEventLocation];

    cell.eventEntryTypeLabel.text = [event valueForKey:kEventType];

    cell.eventThumbnailImageView.image = [UIImage imageNamed:[event valueForKey:kImageURL]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kDetailEventSegue sender:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - PrepareforSegue Method

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:kDetailEventSegue]) {
		ETEventDetailViewController *eventDetailController = [segue destinationViewController];
		NSIndexPath *indexPath = [self.eventsTableView indexPathForSelectedRow];
		Event *event = [self.eventsArray objectAtIndex:indexPath.row];
		eventDetailController.eventID = [event valueForKey:kEventID];
	}
}

#pragma mark - TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![textField.text isEqualToString:@""]) {
        
		NSString *userName = textField.text;
		
		[kETUserDefaults setUserName:[userName lowercaseString]];

		[DataManager addUserWithName:[userName lowercaseString]];
		
        [AlertViewManager dismissAlertView];
        
        self.eventsArray = [DataManager fetchEvents];
                
        [self.eventsTableView setDelegate:self];
        [self.eventsTableView setDataSource:self];
        
        [self.eventsTableView reloadData];
        
        return YES;
    }
    return NO;
}

@end
