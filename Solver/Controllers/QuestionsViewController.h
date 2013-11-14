//
//  QuestionsViewController.h
//  Solver
//
//  Created by Sergii Lantratov on 11/12/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//


@interface QuestionsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *questionsTableView;
@property (weak, nonatomic) IBOutlet UIView *addQuestionView;

- (IBAction)doneTouchInside:(id)sender;
- (IBAction)addQuestionTouchInside:(id)sender;

@end
