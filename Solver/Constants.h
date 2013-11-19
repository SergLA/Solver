//
//  Constants.h
//  Solver
//
//  Created by Sergii Lantratov on 11/12/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//


#pragma mark - Storage

extern NSString * const STORAGE_FILE_NAME;
extern NSString * const STORAGE_SELECTED_QUESTION_INDEX;
extern NSString * const QUESTION_ABOUT_BEER;
extern NSString * const QUESTION_ABOUT_CAR;
extern NSString * const QUESTION_ABOUT_LUNCH;
extern NSString * const QUESTION_ABOUT_LEAD;
extern NSString * const QUESTION_ABOUT_SOMETHING_LONG;
extern NSString * const DID_APPLICATION_ALREADY_RUN_KEY;
extern NSString * const NEW_APPLICATION_START_KEY;
extern NSString * const SHOULD_START_WITH_QUESTION_SCREEN_KEY;
extern NSString * const SHOULD_REMOVE_WINNING_PHOTO_KEY;


#pragma mark - Notification Settings

extern NSString * const PHOTOS_UPDATE_NOTIFICATION;
extern NSString * const UPDATE_KIND_KEY;
extern NSString * const ADD_PHOTO_UPDATE;
extern NSString * const REMOVE_PHOTO_UPDATE;
extern NSString * const CLEAR_PHOTOS_UPDATE;


#pragma mark - Different Stuff

extern NSString * const FONT_NAME;
extern float const FONT_SIZE;

NSString * const DELETE_ROW_CONFIRMATION;


#pragma mark - Functions

UIColor* RGBA(float r, float g, float b, float a);
NSString* filePathForFileName(NSString *fileName);
UIImage* randomImageWithNumber(NSInteger number);