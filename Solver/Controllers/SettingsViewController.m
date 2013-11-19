//
//  SettingsViewController.m
//  Solver
//
//  Created by Sergii Lantratov on 11/16/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//


#import "SettingsViewController.h"
#import "AboutViewController.h"
#import "Settings.h"


@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Settings";

    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouchInside:)];
    
    [self placeSwitchers];
    self.startWithQuestionPageSwitch.on = [Settings defaultSettings].shouldStartWithQuestionScreen;
    self.removeWinningPhotoSwitch.on = [Settings defaultSettings].shouldRemoveWinningPhoto;
}


#pragma mark - Actions methods

- (IBAction)doneTouchInside:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)startWithQuestionPageSwitchValueChanged:(UISwitch*)sender
{
    [Settings defaultSettings].shouldStartWithQuestionScreen = sender.on;
}

- (IBAction)removeWinningPhotoSwitchValueChanged:(UISwitch*)sender
{
    [Settings defaultSettings].shouldRemoveWinningPhoto = sender.on;
}

- (IBAction)aboutTouchInside:(id)sender
{
    AboutViewController *aboutViewController = [AboutViewController new];
    
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

- (IBAction)clearTouchInside:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Solver"
                                                    message:@"There will be deletion of all data. Not implemented yet."
                                                   delegate:nil
                                          cancelButtonTitle:@"NO"
                                          otherButtonTitles:@"YES", nil];
    [alert show];
}


#pragma mark - Private methods

- (void)placeSwitchers
{
    CGRect newRect = self.startWithQuestionPageSwitch.frame;
    newRect.origin.x = self.view.frame.size.width - newRect.size.width - 20.0;
    self.startWithQuestionPageSwitch.frame = newRect;
    
    newRect = self.removeWinningPhotoSwitch.frame;
    newRect.origin.x = self.view.frame.size.width - newRect.size.width - 20.0;
    self.removeWinningPhotoSwitch.frame = newRect;
}

@end
