//
//  PhotoSlider1.m
//  Solver
//
//  Created by Sergii Lantratov on 11/24/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//

#import "PhotoSlider1.h"
#import "Constants.h"
#import "PhotosDataSource.h"

@implementation PhotoSlider1

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.delegate = self;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photosUpdated:)
                                                     name:PHOTOS_UPDATE_NOTIFICATION object:nil];
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)photosUpdated:(NSNotification *)notification
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat x = self.frame.size.height;
    for (UIImage *photo in [[PhotosDataSource defaultDataSource] allPhotos])
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, self.frame.size.height, self.frame.size.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = photo;
        
        [self addSubview:imageView];
        
        x += self.frame.size.height;
    }
    x += self.frame.size.height;
    
    self.contentSize = CGSizeMake(x, self.frame.size.height);
    
    [self setNeedsDisplay];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (UIImageView *photo in self.subviews)
    {
        float position = photo.center.x-self.contentOffset.x;
        float offset = lroundf(2.0-(abs(self.center.x-position)*1.0)/self.center.x) % 7 + 1;
        

        CGAffineTransform rotate = CGAffineTransformScale(CGAffineTransformIdentity, 1/offset, 1.0);
        CGAffineTransform translate = CGAffineTransformTranslate(rotate, 5*position, 0);
        [photo setTransform:translate];
        
//        photo.transform = CGAffineTransformIdentity;
//        photo.transform = CGAffineTransformScale(photo.transform, offset, offset);
    }
}

@end
