//
//  SettingsViewController.m
//  Solver
//
//  Created by Sergii Lantratov on 11/16/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//


#import "SettingsViewController.h"
#import "AboutViewController.h"


@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Settings";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouchInside:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneTouchInside:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)aboutTouchInside:(id)sender
{
    AboutViewController *aboutViewController = [AboutViewController new];
    
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

@end
