//
//  PersonalLibraryServiceImpl.m
//  ezDL
//
//  Created by Robert Witt on 04.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersonalLibraryServiceImpl.h"
#import "CoreDataStack.h"


@interface PersonalLibraryServiceImpl ()

@property (nonatomic, weak, readonly) CoreDataStack *coreDataStack;
@property (nonatomic, strong) NSMutableArray *groups;

- (NSArray *)fetchGroups;

@end


@implementation PersonalLibraryServiceImpl

@synthesize groups = _groups;

- (CoreDataStack *)coreDataStack
{
    return [CoreDataStack sharedCoreDataStack];
}

- (NSMutableArray *)groups
{
    if (!_groups) _groups = [NSMutableArray arrayWithArray:[self fetchGroups]];
    return _groups;
}

- (NSArray *)fetchGroups
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:CoreDataEntityPersonalLibraryGroup
                                              inManagedObjectContext:self.coreDataStack.managedObjectContext];
    request.entity = entity;
    
    NSArray *result = [self.coreDataStack.managedObjectContext executeFetchRequest:request error:nil];
    return result;
}

- (PersonalLibraryGroup *)newGroupWithName:(NSString *)name
{
    PersonalLibraryGroup *group = (PersonalLibraryGroup *)[NSEntityDescription insertNewObjectForEntityForName:CoreDataEntityPersonalLibraryGroup
                                                                                            inManagedObjectContext:self.coreDataStack.managedObjectContext];
    group.name = name;
    return group;
}

- (void)saveGroup:(PersonalLibraryGroup *)group
{
    [self.coreDataStack saveContext];
    [self.groups addObject:group];
}

- (NSArray *)personalLibraryGroups
{
    return self.groups;
}

- (PersonalLibraryReference *)newReferenceWithDocument:(Document *)document
{
    PersonalLibraryReference *reference = (PersonalLibraryReference *)[NSEntityDescription insertNewObjectForEntityForName:CoreDataEntityPersonalLibraryReference
                                                                                                        inManagedObjectContext:self.coreDataStack.managedObjectContext];
    reference.document = document;
    return reference;
}

- (void)saveReference:(PersonalLibraryReference *)reference
{
    [self.coreDataStack saveContext];
    // TODO Implementation needed
}

@end