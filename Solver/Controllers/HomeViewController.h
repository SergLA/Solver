//
//  HomeViewController.h
//  Solver
//
//  Created by Sergii Lantratov on 11/12/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *ballViewPlaceholder;
@property (weak, nonatomic) IBOutlet UIImageView *ballImageView;
@property (weak, nonatomic) IBOutlet UIImageView *winningPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

- (IBAction)addPhotoTouchInside:(id)sender;
- (IBAction)addPhotoFromCameraRollTouchInside:(id)sender;
- (IBAction)addPhotoFromContactsTouchInside:(id)sender;
- (IBAction)deletePhotosTouchInside:(id)sender;

- (IBAction)questionsTouchInside:(id)sender;
- (IBAction)settingsTouchInside:(id)sender;

@end
