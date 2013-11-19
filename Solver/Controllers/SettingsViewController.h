//
//  SettingsViewController.h
//  Solver
//
//  Created by Sergii Lantratov on 11/16/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *startWithQuestionPageSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *removeWinningPhotoSwitch;

- (IBAction)startWithQuestionPageSwitchValueChanged:(UISwitch*)sender;
- (IBAction)removeWinningPhotoSwitchValueChanged:(UISwitch*)sender;

- (IBAction)aboutTouchInside:(id)sender;
- (IBAction)clearTouchInside:(id)sender;

@end
