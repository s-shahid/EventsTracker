//
//  ETDataManager.m
//  EventsTracker
//
//  Created by Mohammed Shahid on 20/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import "ETDataManager.h"

@implementation ETDataManager

+ (id) sharedInstance
{
    static ETDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ETDataManager alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Fetch Events

-(NSMutableArray *)fetchEvents
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:kEventEntity inManagedObjectContext:SharedCoreData.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kEventName ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error;
    
    NSMutableArray *mutableFetchResults = [[SharedCoreData.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (!mutableFetchResults) {
        ETLog(@"No data");
    }
    return mutableFetchResults;
}

#pragma mark - Fetch Event Details for an event

- (Event *) fetchEventDetailsForEventWithID:(NSString *)eventID
{
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:kEventEntity inManagedObjectContext:SharedCoreData.managedObjectContext];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"eventID == %@",eventID];
    [request setPredicate:predicate];
    
    NSArray *resultArray = nil;
    NSError *error;
    
    resultArray = [SharedCoreData.managedObjectContext executeFetchRequest:request error:&error];
    
    Event *result = nil;
    if ([resultArray count] > 0) {
        result = [resultArray objectAtIndex:0];
    }
    
    return result;
}

#pragma mark - Add User

- (void) addUserWithName:(NSString *)userName
{
	User *user = [self lookUpForUserWithName:userName];
	
	if (!user) {
		NSManagedObject *userDetails = [NSEntityDescription insertNewObjectForEntityForName:kUserEntity inManagedObjectContext:SharedCoreData.managedObjectContext];
        
        [userDetails setValue:userName forKey:kUserName];
		
		[SharedCoreData saveContext];
	}
}

#pragma mark - Lookup for User

- (User *) lookUpForUserWithName:(NSString *)userName
{
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:kUserEntity inManagedObjectContext:SharedCoreData.managedObjectContext];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userName == %@",userName];
    [request setPredicate:predicate];
    
    NSArray *resultArray = nil;
    NSError *error;
    
    resultArray = [SharedCoreData.managedObjectContext executeFetchRequest:request error:&error];
    
    User *result = nil;
    if ([resultArray count] > 0) {
        result = [resultArray objectAtIndex:0];
    }
    
    return result;
}

#pragma mark - Lookup for User

- (Event *) lookUpForEventWithID:(NSString *)eventID
{
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:kEventEntity inManagedObjectContext:SharedCoreData.managedObjectContext];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"eventID == %@",eventID];
    [request setPredicate:predicate];
    
    NSArray *resultArray = nil;
    NSError *error;
    
    resultArray = [SharedCoreData.managedObjectContext executeFetchRequest:request error:&error];
    
    Event *result = nil;
    if ([resultArray count] > 0) {
        result = [resultArray objectAtIndex:0];
    }
    
    return result;
}

#pragma mark - Track Events

- (void)trackEventWithID:(NSString *)eventID forUser:(NSString *)userName
{
	Event *event = [self lookUpForEventWithID:eventID];
	User *user = [self lookUpForUserWithName:userName];
	
	if (user && event) {
		[user addEventObject:event]; //inverse is automatically set
	}
	
	[SharedCoreData saveContext];
}

#pragma mark - UnTrack Events

- (void)unTrackEventWithID:(NSString *)eventID forUser:(NSString *)userName
{
	Event *event = [self lookUpForEventWithID:eventID];
	User *user = [self lookUpForUserWithName:userName];
	
	if (user && event) {
		[user removeEventObject:event]; //inverse is automatically removed
	}
	
	[SharedCoreData saveContext];
}

#pragma mark - Fetch User Tracked Events

-(NSSet *)fetchTrackedEventsofUser:(NSString *)userName
{
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:kUserEntity inManagedObjectContext:SharedCoreData.managedObjectContext];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userName == %@", userName];
    [request setPredicate:predicate];
    
    NSArray *resultArray = nil;
    NSError *error;
    
    resultArray = [SharedCoreData.managedObjectContext executeFetchRequest:request error:&error];
    
    User *user = nil;
    if ([resultArray count] > 0) {
        user = [resultArray objectAtIndex:0];
    }
	
    NSSet *eventSet = nil;
    if (user) {
		eventSet = user.event;
	}
	
	return eventSet;
}

@end
