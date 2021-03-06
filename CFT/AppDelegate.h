//
//  AppDelegate.h
//  CFT
//
//  Created by Must on 3/5/16.
//  Copyright © 2016 Must. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "JASidePanelController.h"
#import "NavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property (nonatomic, retain) NSDictionary* celebrity_gender;
@property (nonatomic, retain) NSArray* nameArray;
@property (nonatomic, retain) NSArray* genderArray;

@property (readwrite) long selectedMenu;

@property (retain, nonatomic) JASidePanelController* sideviewController;
@property (retain, nonatomic) NavigationController* nav;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

