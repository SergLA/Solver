//
//  QuestionsViewController.m
//  Solver
//
//  Created by Sergii Lantratov on 11/12/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//

#import "QuestionsViewController.h"
#import "QuestionsDataSource.h"
#import "Constants.h"
#import "AddQuestionViewController.h"

@interface QuestionsViewController ()

@end

@implementation QuestionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    CGRect rect = self.addQuestionView.frame;
    rect.origin.y += rect.size.height;
    self.addQuestionView.frame = rect;
    
    rect = self.questionsTableView.frame;
    rect.size.height = self.view.frame.size.height - rect.origin.y;
    self.questionsTableView.frame = rect;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.questionsTableView reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[QuestionsDataSource defaultDataSource] selectedQuestionIndex] inSection:0];
    if (indexPath.row < [[[QuestionsDataSource defaultDataSource] allQuestions] count])
    {
        [self.questionsTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}


#pragma mark - Private methods

- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
    [super setEditing:editing animated:animate];
    [self.questionsTableView setEditing:editing animated:animate];
    
    CGRect viewFrame = self.view.frame;
    CGRect addQuestionFrame = self.addQuestionView.frame;
    CGRect questionsTableFrame = self.questionsTableView.frame;
    
    if (editing)
    {
        addQuestionFrame.origin.y = viewFrame.size.height - addQuestionFrame.size.height;
        questionsTableFrame.size.height = viewFrame.size.height - questionsTableFrame.origin.y - addQuestionFrame.size.height;
    }
    else
    {
        addQuestionFrame.origin.y = viewFrame.size.height + addQuestionFrame.size.height;
        questionsTableFrame.size.height = viewFrame.size.height - questionsTableFrame.origin.y;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.addQuestionView.frame = addQuestionFrame;
        self.questionsTableView.frame = questionsTableFrame;
    }];
}


#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = [[[QuestionsDataSource defaultDataSource] allQuestions] objectAtIndex:indexPath.row];
    UIFont *cellFont = [UIFont fontWithName:FONT_NAME size:FONT_SIZE];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont
                            constrainedToSize:constraintSize
                                lineBreakMode:NSLineBreakByWordWrapping];
    
    return labelSize.height + 25;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DELETE_ROW_CONFIRMATION;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [[QuestionsDataSource defaultDataSource] selectQuestionAtIndex:indexPath.row];
    
    [self.questionsTableView reloadData];
}


#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[QuestionsDataSource defaultDataSource] allQuestions] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"QuestionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont fontWithName:FONT_NAME size:FONT_SIZE];
        cell.textLabel.textColor = [UIColor redColor];
    }
    
    cell.textLabel.text = [[[QuestionsDataSource defaultDataSource] allQuestions] objectAtIndex:indexPath.row];
    if (indexPath.row == [[QuestionsDataSource defaultDataSource] selectedQuestionIndex])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[QuestionsDataSource defaultDataSource] moveQuestionFromIndex:sourceIndexPath.row ToIndex:destinationIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[QuestionsDataSource defaultDataSource] removeQuestionFromIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - Actions handlers

- (IBAction)doneTouchInside:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addQuestionTouchInside:(id)sender
{
    if (self.isEditing)
    {
        [self setEditing:NO animated:YES];
    }
    
    AddQuestionViewController *addQuestionViewController = [AddQuestionViewController new];
    
    [self presentViewController:addQuestionViewController animated:YES completion:nil];
}

@end
