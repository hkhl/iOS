//
//  DeviceDetailViewControllerUIViewController.m
//  coreData-Mystore
//
//  Created by deerwang(王东东) on 2019/8/15.
//  Copyright © 2019 deerwang. All rights reserved.
//

#import "DeviceDetailViewControllerUIViewController.h"
#import "DeviceTableViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface DeviceDetailViewControllerUIViewController ()


@end

@implementation DeviceDetailViewControllerUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    // 1. 获取NSManagedObjectContext对象
    AppDelegate *appDelegate = (id)[UIApplication sharedApplication].delegate;
    //NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    if ([appDelegate respondsToSelector:@selector(persistentContainer)]) {
        context = appDelegate.persistentContainer.viewContext;
    }
    return context;
}


- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
    [newDevice setValue:self.nameTextField.text forKey:@"name"];
    [newDevice setValue:self.versionTextField.text forKey:@"version"];
    [newDevice setValue:self.companyTextField.text forKey:@"company"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
