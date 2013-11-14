//
//  AddQuestionViewController.m
//  Solver
//
//  Created by Sergii Lantratov on 11/13/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//


#import "AddQuestionViewController.h"
#import "QuestionsDataSource.h"


@interface AddQuestionViewController ()

@end


@implementation AddQuestionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


#pragma mark - UITextViewDelegate methods

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // We want to hide keyboard when user finish typing
    // thus we handle return key and restore first responder (i.e. hide keyboard)
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


#pragma mark - Actions handlers

- (IBAction)cancelTouchInside:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addTouchInside:(id)sender
{
    NSString *newQuestion = [NSMutableString stringWithString:self.textView.text];
    newQuestion = [newQuestion stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (newQuestion.length != 0)
    {
        [[QuestionsDataSource defaultDataSource] addQuestionAndSelect:newQuestion];
        [self cancelTouchInside:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Solver" message:@"New question cannot be empty" delegate:nil cancelButtonTitle:@"Retry" otherButtonTitles:nil];
        [alertView show];
    }
}

@end
