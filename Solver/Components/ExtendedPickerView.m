//
//  FSExtendedPickerView.m
//  Solver
//
//  Created by Sergii Lantratov on 11/13/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//


#import "ExtendedPickerView.h"


@interface ExtendedPickerView ()
{
@private
    id<ExtendedPickerViewDelegate> extendedDelegate;
}

@end


@implementation ExtendedPickerView

- (id<ExtendedPickerViewDelegate>)delegate
{
    return extendedDelegate;
}

- (void)setDelegate:(id<ExtendedPickerViewDelegate>)d
{
    extendedDelegate = d;
    [super setDelegate:d];
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView* result = [super hitTest:point withEvent:event];
    [self.delegate pickerView:self didHitTest:point withEvent:event];
    
    return result;
}

@end
