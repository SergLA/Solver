//
//  Constants.m
//  Solver
//
//  Created by Sergii Lantratov on 11/12/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//

#import "Constants.h"

#pragma mark - Storage

NSString * const STORAGE_FILE_NAME = @"Questions.plist";
NSString * const STORAGE_SELECTED_QUESTION_INDEX = @"Selected Question Index";
NSString * const QUESTION_ABOUT_BEER = @"Who will go out for some beer?";
NSString * const QUESTION_ABOUT_CAR = @"Who will drive a car?";
NSString * const QUESTION_ABOUT_LUNCH = @"Who has to pay for lunch?";
NSString * const QUESTION_ABOUT_LEAD = @"Who is going to lead?";
NSString * const QUESTION_ABOUT_SOMETHING_LONG = @"Some very long question about something very important!";
NSString * const DID_APPLICATION_ALREADY_RUN_KEY = @"Brand new application start";
NSString * const NEW_APPLICATION_START_KEY = @"New application start";
NSString * const SHOULD_START_WITH_QUESTION_SCREEN_KEY = @"Should Start With Question Screen";
NSString * const SHOULD_REMOVE_WINNING_PHOTO_KEY = @"Should Remove Winning Photo";


#pragma mark - Notification Settings
NSString * const PHOTOS_UPDATE_NOTIFICATION = @"FriendsUpdated";
NSString * const UPDATE_KIND_KEY = @"UpdateKind";
NSString * const ADD_PHOTO_UPDATE = @"AddFriend";
NSString * const REMOVE_PHOTO_UPDATE = @"RemoveFriend";
NSString * const CLEAR_PHOTOS_UPDATE = @"ClearFriends";


#pragma mark - Different Stuff

NSString * const FONT_NAME = @"Helvetica";
float const FONT_SIZE = 17.0;


NSString * const DELETE_ROW_CONFIRMATION = @"Remove?";


#pragma mark - Functions

const CGFloat imageWidthHeight = 300.0;

UIColor* RGBA(float r, float g, float b, float a)
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

NSString* filePathForFileName(NSString *fileName)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    return path;
}

CGRect getRandomSquare(CGRect containerRect, float maxWidth)
{
    CGFloat x = (rand() % lroundf(containerRect.size.width)) - (maxWidth / 2.0);
    CGFloat y = (rand() % lroundf(containerRect.size.height)) - (maxWidth / 2.0);
    CGFloat widthHeight = (rand() % lroundf(maxWidth * 2.0 / 3.0)) + maxWidth / 3.0;
    
    return CGRectMake(x, y, widthHeight, widthHeight);
}

UIImage* randomImageWithNumber(NSInteger number)
{
    CGRect imageRect = CGRectMake(0.0f, 0.0f, imageWidthHeight, imageWidthHeight);
    UIGraphicsBeginImageContext(imageRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Add some background
    UIColor *color = RGBA(rand() % 255, rand() % 255, rand() % 255, 0.85);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, imageRect);
    
    // Add some sircles
    for (int i = 0; i<4; i++)
    {
        CGContextSetLineWidth(context, 3.0);
        color = RGBA(rand() % 255, rand() % 255, rand() % 255, 0.6);
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextBeginPath(context);
        CGContextAddEllipseInRect(context, getRandomSquare(imageRect, 0.85*imageWidthHeight));
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
    // Text stuff
    NSString *string = [NSString stringWithFormat:@"%ld", (long)number];
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect textRect = imageRect;
    textRect.origin.y = (number >= 100) ? 50 : 2;
    [string drawInRect:textRect
              withFont:[UIFont systemFontOfSize:(number >= 100) ? 160 : 254]
         lineBreakMode:NSLineBreakByClipping
             alignment:NSTextAlignmentCenter];
    
    // Generate image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

UIImage* defaultUserpicImageWithString(NSString *string)
{
    CGRect imageRect = CGRectMake(0.0f, 0.0f, imageWidthHeight, imageWidthHeight);
    UIGraphicsBeginImageContext(imageRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Default image
    // Little trick: by default we draw upsidedown, so we have to
    // turn context (invert vertically), draw image and restore
    // previous content's state.
    CGContextSaveGState(context);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -imageRect.size.height);
    UIImage *tmpImage = [UIImage imageNamed:@"blank"];
    CGContextDrawImage(context, imageRect, tmpImage.CGImage);
    CGContextRestoreGState(context);
    
    // Text stuff
    CGSize textSize = [string sizeWithFont:[UIFont systemFontOfSize:36] constrainedToSize:imageRect.size lineBreakMode:NSLineBreakByWordWrapping];
    CGRect textRect = CGRectZero;
    textRect.origin.x = (imageRect.size.width - textSize.width) / 2.0;
    textRect.origin.y = imageRect.size.height - textSize.height;
    textRect.size = textSize;
    
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
    [string drawInRect:textRect
              withFont:[UIFont systemFontOfSize:36]
         lineBreakMode:NSLineBreakByWordWrapping
             alignment:NSTextAlignmentCenter];
    
    // Generate image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

