//
//  ETSharedCoreData.m
//  EventsTracker
//
//  Created by Mohammed Shahid on 20/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import "ETSharedCoreData.h"

@implementation ETSharedCoreData

static ETSharedCoreData * sharedInstanceManager = nil;

#pragma mark Initialization methods

+ (ETSharedCoreData *) sharedInstance
{
	@synchronized(self)
	{
		if (sharedInstanceManager == nil)
		{
			sharedInstanceManager = [[ETSharedCoreData alloc] init];
		}
	}
    
	return sharedInstanceManager;
}

#pragma mark - Core Data stack

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
- (NSPersistentStoreCoordinator *) persistentStoreCoordinator
{
	if (persistentStoreCoordinator != nil)
	{
		return persistentStoreCoordinator;
	}
	NSError *error = nil;
    
    NSString *filePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"EventTracker.sqlite"];
	NSURL *storeUrl = [NSURL fileURLWithPath:filePath];
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSString *bundleFile = [[NSBundle mainBundle] pathForResource:@"EventTracker" ofType:@"sqlite"];
        [[NSFileManager defaultManager] copyItemAtPath:bundleFile toPath:filePath error:&error];
        if(error) {
            ETLog(@"FATAL Error copying store file - %@",error);
            NSAssert(0, @"Failed to add database");
            exit(-2);
        }
    }
    
	error = nil;
	persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
	if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error])
	{
		/*Error for store creation should be handled in here*/
        ETLog(@"Error - %@", error);
        NSAssert(0, @"Failed to create persistent store");
        exit(-2);
	}
    
	return persistentStoreCoordinator;
}


#pragma mark - Application's Documents directory

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
            ETLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
