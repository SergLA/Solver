//
//  PhotoSlider.m
//  Solver
//
//  Created by Sergii Lantratov on 11/13/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//


#import "PhotoSlider.h"
#import "ExtendedPickerView.h"
#import "PhotosDataSource.h"
#import "Constants.h"


@interface PhotoSlider () <ExtendedPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, retain) ExtendedPickerView *pickerView;
@property (nonatomic, retain) UIButton *deleteButton;

@end


@implementation PhotoSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photosUpdated:)
                                                     name:PHOTOS_UPDATE_NOTIFICATION object:nil];
        
        self.pickerView = [[ExtendedPickerView alloc] initWithFrame:CGRectZero];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        self.pickerView.backgroundColor = [UIColor clearColor];
        
        CGAffineTransform rotate = CGAffineTransformMakeRotation(M_PI_2);
        rotate = CGAffineTransformScale(rotate, 0.25, 1.0);
        [self.pickerView setTransform:rotate];
        [self.pickerView setCenter:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0)];
        
        [self addSubview:self.pickerView];
        
        UIImage *image = [UIImage imageNamed:@"trash.png"];
        CGRect rect = CGRectMake(2.0*self.frame.size.width/3.0 - image.size.width, 0,
                                 image.size.width, image.size.height);
        self.deleteButton = [[UIButton alloc] initWithFrame:rect];
        [self.deleteButton setImage:image forState:UIControlStateNormal];
        [self.deleteButton setBackgroundColor:[UIColor clearColor]];
        [self.deleteButton addTarget:self action:@selector(deleteButtonTouchInside:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.deleteButton];
    }
    return self;
}

- (void)photosUpdated:(NSNotification *)notification
{
    NSInteger count = [[[PhotosDataSource defaultDataSource] allPhotos] count];
    
    NSString *updateKind = [[notification userInfo] objectForKey:UPDATE_KIND_KEY];

    if (count > 0)
    {
        [self.pickerView reloadAllComponents];
    }
    
    if ([updateKind isEqualToString:CLEAR_PHOTOS_UPDATE] ||
        ([updateKind isEqualToString:REMOVE_PHOTO_UPDATE] && (0 == count)))
    {
        // This conditions hits when FSPhotoSlider view could be destroyed.
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    
    if ([updateKind isEqualToString:ADD_PHOTO_UPDATE])
    {
        [self.pickerView selectRow:(count - 1) inComponent:0 animated:YES];
        if (1 == count)
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photosUpdated:)
                                                         name:PHOTOS_UPDATE_NOTIFICATION object:nil];
        }
    }
    
    BOOL isHidden = !(count > 0);
    [self.deleteButton setHidden:isHidden];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[[PhotosDataSource defaultDataSource] allPhotos] count];
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didHitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    [self.deleteButton setHidden:YES];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    BOOL isHidden = !([[[PhotosDataSource defaultDataSource] allPhotos] count] > 0);
    [self.deleteButton setHidden:isHidden];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.frame.size.width / 3.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGRect rect = CGRectMake(0, 0, self.frame.size.width / 3.0, self.frame.size.width / 3.0);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    UIImage *tmpImage = [[PhotosDataSource defaultDataSource] photoAtIndex:row];
    [imageView setImage:tmpImage];
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation(- M_PI_2);
    rotate = CGAffineTransformScale(rotate, 1.0, 4.0);
    [imageView setTransform:rotate];
    
    return imageView;
}

- (void)deleteButtonTouchInside:(id)sender
{
    [[PhotosDataSource defaultDataSource] removePhotoFromIndex:[self.pickerView selectedRowInComponent:0]];
}

@end
