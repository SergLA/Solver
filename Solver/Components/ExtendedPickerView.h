//
//  FSExtendedPickerView.h
//  Solver
//
//  Created by Sergii Lantratov on 11/13/13.
//  Copyright (c) 2013 Sergii Lantratov. All rights reserved.
//


@protocol ExtendedPickerViewDelegate <UIPickerViewDelegate>

@optional
- (void)pickerView:(UIPickerView *)pickerView didHitTest:(CGPoint)point withEvent:(UIEvent *)event;

@end


@interface ExtendedPickerView : UIPickerView

@property (nonatomic, assign) id<ExtendedPickerViewDelegate> delegate;

@end
