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

NSString* filePathForFileName(NSString *fileName)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    return path;
}