//
//  Settings.h
//  Solver
//
//  Created by Sergii Lantratov on 11/17/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//


@interface Settings : NSObject

+ (Settings *)defaultSettings;

@property (nonatomic, assign) BOOL didApplicationAlreadyRun;
@property (nonatomic, assign) BOOL newApplicationStart;

@property (nonatomic, assign) BOOL shouldStartWithQuestionScreen;
@property (nonatomic, assign) BOOL shouldRemoveWinningPhoto;


@end
