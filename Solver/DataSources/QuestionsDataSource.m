//
//  QuestionsDataSource.m
//  Solver
//
//  Created by Sergii Lantratov on 11/12/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//

#import "QuestionsDataSource.h"
#import "Constants.h"


static QuestionsDataSource *dataSource = nil;


@interface QuestionsDataSource ()

@property (nonatomic, strong) NSMutableArray *questions;
@property (nonatomic, assign) NSInteger selectedIndex;

@end


@implementation QuestionsDataSource


#pragma mark - Initialization

+ (QuestionsDataSource *)defaultDataSource
{
    if (nil == dataSource)
    {
        dataSource = [[super allocWithZone:NULL] init];
    }
    
    return dataSource;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultDataSource];
}

- (id)init
{
    if (nil != dataSource)
    {
        return dataSource;
    }
    
    self = [super init];
    
    if (self)
    {
        self.questions = [NSMutableArray new];
        [self.questions addObjectsFromArray:[NSArray arrayWithContentsOfFile:filePathForFileName(STORAGE_FILE_NAME)]];
        
        if (self.questions.count == 0)
        {
            [self.questions addObject:QUESTION_ABOUT_BEER];
            [self.questions addObject:QUESTION_ABOUT_CAR];
            [self.questions addObject:QUESTION_ABOUT_LEAD];
            [self.questions addObject:QUESTION_ABOUT_LUNCH];
            [self.questions addObject:QUESTION_ABOUT_SOMETHING_LONG];
        }
        
        self.selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:STORAGE_SELECTED_QUESTION_INDEX];
        if ((self.selectedIndex < 0) || (self.selectedIndex > self.questions.count))
        {
            self.selectedIndex = 0;
        }
    }
    
    return self;
}


#pragma mark - Data Structure Methods

- (NSArray *)allQuestions
{
    return self.questions;
}

- (NSString *)selectedQuestion
{
    NSString *selectedQuestion = @"Please add question for solving";
    if ((self.selectedIndex >= 0) && (self.selectedIndex < self.questions.count))
    {
        selectedQuestion = [self.questions objectAtIndex:self.selectedIndex];
    }
    
    return selectedQuestion;
}

- (NSInteger)selectedQuestionIndex
{
    return ((self.selectedIndex >= 0) && (self.selectedIndex < self.questions.count)) ? self.selectedIndex : 0;
}

- (void)selectQuestionAtIndex:(NSInteger)index
{
    if ((index >= 0) && (index < self.questions.count))
    {
        self.selectedIndex = index;
    }
}

- (void)removeQuestionFromIndex:(int)index
{
    [self.questions removeObjectAtIndex:index];
    
    if ((self.selectedIndex >= index) && (self.selectedIndex != 0))
    {
        self.selectedIndex -=1;
    }
}

- (void)addQuestion:(NSString *)question
{
    [self.questions addObject:question];
}

- (void)addQuestionAndSelect:(NSString *)question
{
    [self addQuestion:question];
    self.selectedIndex = self.questions.count - 1;
}

- (void)moveQuestionFromIndex:(int)from ToIndex:(int)to
{
    if (from == to)
    {
        return;
    }
    
    NSString *tmp = [[self.questions objectAtIndex:from] copy];
    
    [self.questions removeObjectAtIndex:from];
    [self.questions insertObject:tmp atIndex:to];
    
    if (self.selectedIndex == from)
    {
        self.selectedIndex = to;
    }
}

- (void)saveQuestions
{
    [[NSUserDefaults standardUserDefaults] setInteger:self.selectedIndex forKey:STORAGE_SELECTED_QUESTION_INDEX];
    
    [self.questions writeToFile:filePathForFileName(STORAGE_FILE_NAME) atomically:YES];
}

@end
