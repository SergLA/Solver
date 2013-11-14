//
//  AddQuestionViewController.h
//  Solver
//
//  Created by Sergii Lantratov on 11/13/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//


@interface AddQuestionViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)cancelTouchInside:(id)sender;
- (IBAction)addTouchInside:(id)sender;

@end
