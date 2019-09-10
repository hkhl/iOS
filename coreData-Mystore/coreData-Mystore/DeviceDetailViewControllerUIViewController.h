//
//  DeviceDetailViewControllerUIViewController.h
//  coreData-Mystore
//
//  Created by deerwang(王东东) on 2019/8/15.
//  Copyright © 2019 deerwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceDetailViewControllerUIViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *versionTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
@end

NS_ASSUME_NONNULL_END
