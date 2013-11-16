//
//  HomeViewController.m
//  Solver
//
//  Created by Sergii Lantratov on 11/12/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//


#import "UIImage+Resize.h"
#import "HomeViewController.h"
#import "Constants.h"
#import "QuestionsDataSource.h"
#import "PhotosDataSource.h"
#import "PhotoSlider.h"
#import "QuestionsViewController.h"
#import "SettingsViewController.h"


@interface HomeViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) PhotoSlider *photoSlider;

@end


@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photosUpdated:)
                                                 name:PHOTOS_UPDATE_NOTIFICATION object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.questionLabel.text = [[QuestionsDataSource defaultDataSource] selectedQuestion];
}


#pragma mark - Private methods

- (void)setupPhotoSlider
{
    CGRect photoSliderFrame = CGRectMake(40, 58, 240, 80);
    PhotoSlider *slider = [[PhotoSlider alloc] initWithFrame:photoSliderFrame];
    
    self.photoSlider = slider;
    [self.view addSubview:self.photoSlider];
}

- (void)photosUpdated:(NSNotification *)notification
{
    NSInteger photosCount = [[[PhotosDataSource defaultDataSource] allPhotos] count];
    
    NSString *updateKind = [[notification userInfo] objectForKey:UPDATE_KIND_KEY];
    
    if ([updateKind isEqualToString:CLEAR_PHOTOS_UPDATE] ||
        ([updateKind isEqualToString:REMOVE_PHOTO_UPDATE] && (0 == photosCount)))
    {
        [self.photoSlider removeFromSuperview];
        self.photoSlider = nil;
    }
    
    if ([updateKind isEqualToString:ADD_PHOTO_UPDATE] && (1 == photosCount))
    {
        [self setupPhotoSlider];
    }
}


#pragma mark - Actions handlers

- (IBAction)addPhotoTouchInside:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    imagePicker.allowsEditing = YES;
    imagePicker.showsCameraControls = YES;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)addPhotoFromCameraRollTouchInside:(id)sender
{
    NSString *imageName = [NSString stringWithFormat:@"image%d.png", rand() % 3 + 1];
    UIImage *photo = [UIImage imageNamed:imageName];
    
    [[PhotosDataSource defaultDataSource] addPhoto:photo];
}

- (IBAction)addPhotoFromContactsTouchInside:(id)sender
{
}

- (IBAction)deletePhotosTouchInside:(id)sender
{
    [[PhotosDataSource defaultDataSource] clearPhotos];
}

- (IBAction)questionsTouchInside:(id)sender
{
    QuestionsViewController *questionsViewController = [QuestionsViewController new];
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:questionsViewController animated:YES completion:nil];
}

- (IBAction)settingsTouchInside:(id)sender
{
    SettingsViewController *settingsViewController = [SettingsViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navController animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *photo = [info objectForKey:UIImagePickerControllerOriginalImage];
    photo = [photo resizedImageWithContentMode:UIViewContentModeScaleAspectFit
                                        bounds:CGSizeMake(100, 100)
                          interpolationQuality:kCGInterpolationHigh];
	
    [[PhotosDataSource defaultDataSource] addPhoto:photo];
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
