//
//  QuestionsDataSource.h
//  Solver
//
//  Created by Sergii Lantratov on 11/12/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//


@interface QuestionsDataSource : NSObject

+ (QuestionsDataSource *)defaultDataSource;

- (NSArray *)allQuestions;
- (NSInteger)selectedQuestionIndex;
- (NSString *)selectedQuestion;

- (void)selectQuestionAtIndex:(NSInteger)index;

- (void)removeQuestionFromIndex:(int)index;
- (void)addQuestion:(NSString *)question;
- (void)addQuestionAndSelect:(NSString *)question;
- (void)moveQuestionFromIndex:(int)from ToIndex:(int)to;

- (void)saveQuestions;

@end
