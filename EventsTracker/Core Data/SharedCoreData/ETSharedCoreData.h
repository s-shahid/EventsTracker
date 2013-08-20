//
//  ETSharedCoreData.h
//  EventsTracker
//
//  Created by Mohammed Shahid on 20/08/13.
//  Copyright (c) 2013 Mohammed Shahid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ETSharedCoreData : NSObject

{
    
	NSManagedObjectModel *managedObjectModel;
    
	NSManagedObjectContext *managedObjectContext;
    
	NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


+ (ETSharedCoreData *) sharedInstance;

- (NSString *)applicationDocumentsDirectory;

- (void)saveContext;

@end
