//
//  Settings.m
//  Solver
//
//  Created by Sergii Lantratov on 11/17/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//


#import "Settings.h"
#import "Constants.h"


static Settings *settings = nil;


@implementation Settings

#pragma mark - Initialization

+ (Settings *)defaultSettings
{
    if (nil == settings)
    {
        settings = [[super allocWithZone:NULL] init];
    }
    
    return settings;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultSettings];
}

- (id)init
{
    if (nil != settings)
    {
        return settings;
    }
    
    self = [super init];
    
    if (nil != self)
    {
        self.didApplicationAlreadyRun = [[NSUserDefaults standardUserDefaults] boolForKey:DID_APPLICATION_ALREADY_RUN_KEY];
        self.newApplicationStart = [[NSUserDefaults standardUserDefaults] boolForKey:NEW_APPLICATION_START_KEY];
        self.shouldStartWithQuestionScreen = [[NSUserDefaults standardUserDefaults] boolForKey:SHOULD_START_WITH_QUESTION_SCREEN_KEY];
        self.shouldRemoveWinningPhoto = [[NSUserDefaults standardUserDefaults] boolForKey:SHOULD_REMOVE_WINNING_PHOTO_KEY];
    }
    
    return self;
}


#pragma mark - Properties

- (void)setDidApplicationAlreadyRun:(BOOL)didApplicationAlreadyRun
{
    _didApplicationAlreadyRun = didApplicationAlreadyRun;
    [[NSUserDefaults standardUserDefaults] setBool:didApplicationAlreadyRun forKey:DID_APPLICATION_ALREADY_RUN_KEY];
}

- (void)setNewApplicationStart:(BOOL)newApplicationStart
{
    _newApplicationStart = newApplicationStart;
    [[NSUserDefaults standardUserDefaults] setBool:newApplicationStart forKey:NEW_APPLICATION_START_KEY];
}

- (void)setShouldStartWithQuestionScreen:(BOOL)shouldStartWithQuestionScreen
{
    _shouldStartWithQuestionScreen = shouldStartWithQuestionScreen;
    [[NSUserDefaults standardUserDefaults] setBool:shouldStartWithQuestionScreen forKey:SHOULD_START_WITH_QUESTION_SCREEN_KEY];
}

- (void)setShouldRemoveWinningPhoto:(BOOL)shouldRemoveWinningPhoto
{
    _shouldRemoveWinningPhoto = shouldRemoveWinningPhoto;
    [[NSUserDefaults standardUserDefaults] setBool:shouldRemoveWinningPhoto forKey:SHOULD_REMOVE_WINNING_PHOTO_KEY];
}

@end
