//
//  ETAppDelegate.h
//  EventTrackerDataStore
//
//  Created by Mohammed Shahid on 19/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ETAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSManagedObjectModel *managedObjectModel;
    
	NSManagedObjectContext *managedObjectContext;
    
	NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (nonatomic, strong) NSMutableArray *eventDetailsArray;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) UIWindow *window;

- (NSString *)applicationDocumentsDirectory;

- (void)saveContext;

@end
