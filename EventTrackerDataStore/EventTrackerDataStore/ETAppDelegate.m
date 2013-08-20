//
//  ETAppDelegate.m
//  EventTrackerDataStore
//
//  Created by Mohammed Shahid on 19/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import "ETAppDelegate.h"

@implementation ETAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [self.window makeKeyAndVisible];
    
    [self addEvents];
    
    [self saveContext];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSError *error = nil;
    if (self.managedObjectContext != nil) {
        if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        }
    }
}

#pragma mark - Add Events to Core Data

-(void)addEvents
{
    self.eventDetailsArray = [[NSMutableArray alloc] initWithObjects:@{@"eventId": @"1",@"name": @"Metallica Concert",@"eventType": @"Paid",@"location": @"Palace Grounds",@"imageURL": @"photo_placeholder.png"},@{@"eventId": @"2",@"name": @"Saree Exhibition",@"eventType": @"Free",@"location": @"Malleswaram Grounds",@"imageURL": @"photo_placeholder.png"},@{@"eventId": @"3",@"name": @"Wine tasting event",@"eventType": @"Paid",@"location": @"Links Brewery",@"imageURL": @"photo_placeholder.png"},@{@"eventId": @"4",@"name": @"Startups Meet",@"eventType": @"Paid",@"location": @"Kanteerava Indoor Stadium",@"imageURL": @"photo_placeholder.png"},@{@"eventId": @"5",@"name": @"Summer Noon Party",@"eventType": @"Paid",@"location": @"Kumara Park",@"imageURL": @"photo_placeholder.png"},@{@"eventId": @"6",@"name": @"Rock and Roll nights",@"eventType": @"Paid",@"location": @"Sarjapur Road",@"imageURL": @"photo_placeholder.png"},@{@"eventId": @"7",@"name": @"Barbecue Fridays",@"eventType": @"Paid",@"location": @"Whitefield",@"imageURL": @"photo_placeholder.png"},@{@"eventId": @"8",@"name": @"Summer workshop",@"eventType": @"Free",@"location": @"Indiranagar",@"imageURL": @"photo_placeholder.png"},@{@"eventId": @"9",@"name": @"Impressions & Expressions",@"eventType": @"Free",@"location": @"MG Road",@"imageURL": @"photo_placeholder.png"},@{@"eventId": @"10",@"name": @"Italian carnival",@"eventType": @"Free",@"location": @"Electronic City",@"imageURL": @"photo_placeholder.png"} ,nil];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    for (int count = 0; count < [self.eventDetailsArray count]; count++) {
        NSManagedObject *eventDetails = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:context];
        
        [eventDetails setValue:[[self.eventDetailsArray objectAtIndex:count] objectForKey:@"eventId"] forKey:@"eventID"];
        [eventDetails setValue:[[self.eventDetailsArray objectAtIndex:count] objectForKey:@"name"] forKey:@"name"];
        [eventDetails setValue:[[self.eventDetailsArray objectAtIndex:count] objectForKey:@"location"] forKey:@"place"];
        [eventDetails setValue:[[self.eventDetailsArray objectAtIndex:count] objectForKey:@"eventType"] forKey:@"entryType"];
        [eventDetails setValue:[[self.eventDetailsArray objectAtIndex:count] objectForKey:@"imageURL"] forKey:@"imageURL"];
    }
}

#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
    
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"EventTracker.sqlite"]];
    
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }
    
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - Save Core Data Context

- (void)saveContext
{
    NSError *error = nil;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
