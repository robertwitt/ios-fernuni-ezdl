//
//  MockupPersonalLibraryServiceImpl.m
//  ezDL
//
//  Created by Robert Witt on 04.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MockupPersonalLibraryServiceImpl.h"
#import "CoreDataStack.h"
#import "EntityFactory.h"


@interface MockupPersonalLibraryServiceImpl ()

@property (nonatomic, weak, readonly) CoreDataStack *coreDataStack;
@property (nonatomic, strong) NSMutableArray *groups;

- (NSArray *)fetchGroups;

@end


@implementation MockupPersonalLibraryServiceImpl

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
    PersonalLibraryGroup *group = [[EntityFactory sharedFactory] persistentPersonalLibraryGroup];
    group.name = name;
    return group;
}

- (void)saveGroup:(PersonalLibraryGroup *)group
{
    [self.coreDataStack saveContext];
    [self.groups addObject:group];
}

- (void)deleteGroup:(PersonalLibraryGroup *)group
{
    [self.groups removeObject:group];
    [self.coreDataStack.managedObjectContext deleteObject:group];
    [self.coreDataStack saveContext];
}

- (NSArray *)personalLibraryGroups
{
    return self.groups;
}

- (PersonalLibraryReference *)newReferenceWithDocument:(Document *)document
{
    EntityFactory *factory = [EntityFactory sharedFactory];
    PersonalLibraryReference *reference = [factory persistentPersonalLibraryReference];
    reference.document = [factory persistentDocumentWithDocument:document];
    return reference;
}

- (void)saveReference:(PersonalLibraryReference *)reference
{
    [self.coreDataStack saveContext];
}

- (void)deleteReference:(PersonalLibraryReference *)reference
{
    [reference.group removeReferencesObject:reference];
    [self.coreDataStack.managedObjectContext deleteObject:reference];
    [self.coreDataStack saveContext];
}

- (void)moveReference:(PersonalLibraryReference *)reference toGroup:(PersonalLibraryGroup *)group
{
    reference.group = group;
    [self.coreDataStack saveContext];
}

@end
