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
#import "Settings.h"
#import "QuestionsDataSource.h"
#import "PhotosDataSource.h"
#import "PhotoSlider.h"
#import "QuestionsViewController.h"
#import "SettingsViewController.h"


typedef enum
{
    ViewStateReady,        // View ready for shaking - no need to handle touches
    ViewStatePhotoWinned,  // View shows winning photo insde ball
    ViewStateShowingPhoto, // View shows winning photo on top of the screen
} ViewState;


@interface HomeViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, assign) ViewState state;
@property (nonatomic, weak) PhotoSlider *photoSlider;
@property (nonatomic, assign) NSInteger winningPhotoID;

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
    
//    self.tapOnWinningImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnWinningImage)];
//    self.tapOnExpandedImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnExpandedImage)];
//    
//    [self.ballImageView addGestureRecognizer:self.tapOnWinningImage];
//    [self.winningPhotoImageView addGestureRecognizer:self.tapOnExpandedImage];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.questionLabel.text = [[QuestionsDataSource defaultDataSource] selectedQuestion];
    self.winningPhotoImageView.image = nil;
    [self.ballViewPlaceholder sendSubviewToBack:self.winningPhotoImageView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    [self becomeFirstResponder];
    
    if (![Settings defaultSettings].didApplicationAlreadyRun)
    {
        //Show pretty semitransparent screen with some help
        [Settings defaultSettings].didApplicationAlreadyRun = YES;
    }
    
    if ([Settings defaultSettings].newApplicationStart)
    {
        [Settings defaultSettings].newApplicationStart = NO;
        [self questionsTouchInside:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    
    [super viewWillDisappear:animated];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

- (void)setWinningPhoto
{
    self.winningPhotoImageView.image = [[PhotosDataSource defaultDataSource] photoAtIndex:self.winningPhotoID];
    
    self.state = ViewStatePhotoWinned;
    
    if ([Settings defaultSettings].shouldRemoveWinningPhoto)
    {
        [[PhotosDataSource defaultDataSource] removePhotoFromIndex:self.winningPhotoID];
    }
}

- (void)didTapOnWinningImage
{
    if (nil == self.winningPhotoImageView.image)
    {
        return;
    }
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect rect = CGRectMake(110, 110, 120, 120);
                         self.winningPhotoImageView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         [self.ballViewPlaceholder sendSubviewToBack:self.ballImageView];
                         [UIView animateWithDuration:0.5
                                          animations:^{
                                              CGRect rect = CGRectMake(30, 30, 280, 280);
                                              self.winningPhotoImageView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              self.state = ViewStateShowingPhoto;
                                          }];
                     }];
}

- (void)didTapOnExpandedImage
{
    if (nil == self.winningPhotoImageView.image)
    {
        return;
    }
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect rect = CGRectMake(25, 25, 290, 290);
                         self.winningPhotoImageView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         [self.ballViewPlaceholder sendSubviewToBack:self.ballImageView];
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              CGRect rect = CGRectMake(165, 165, 10, 10);
                                              self.winningPhotoImageView.frame = rect;
                                              self.winningPhotoImageView.alpha = 0.2;
                                          }
                                          completion:^(BOOL finished) {
                                              self.winningPhotoImageView.alpha = 1.0;
                                              self.winningPhotoImageView.image = nil;
                                              self.winningPhotoImageView.frame = CGRectMake(85, 85, 170, 170);
                                              
                                              [self.ballViewPlaceholder sendSubviewToBack:self.winningPhotoImageView];
                                              
                                              self.state = ViewStateReady;
                                          }];
                     }];
    
}


#pragma mark - Actions handlers

- (IBAction)addPhotoTouchInside:(id)sender
{
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        imagePicker.allowsEditing = YES;
        imagePicker.showsCameraControls = YES;
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else
    {
        static NSInteger number = 1;
        NSString *imageName = [NSString stringWithFormat:@"image%d.png", number];
        UIImage *photo = [UIImage imageNamed:imageName];
        number = (number == 3) ? 1 : (number + 1);
        
        [[PhotosDataSource defaultDataSource] addPhoto:photo];
    }
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


#pragma mark - UIResponder methods

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        NSInteger photosCount = [[[PhotosDataSource defaultDataSource] allPhotos] count];
        if (photosCount == 0)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Solver"
                                                                message:@"Please add some photos to be shaked!"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
            return;
        }
        
        self.winningPhotoID = rand() % photosCount;
        
        [self setWinningPhoto];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    switch (self.state)
    {
        case ViewStateReady:
            // Do nothing
            break;
            
        case ViewStatePhotoWinned:
            [self didTapOnWinningImage];
            break;
            
        case ViewStateShowingPhoto:
            [self didTapOnExpandedImage];
            break;
            
        default:
            NSLog(@"Something wrong with HomeView state!");
            break;
    }
}

@end
