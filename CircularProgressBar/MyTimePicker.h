//
//  MyTimePicker.h
//  CircularProgressBar
//
//  Created by mythware on 10/9/15.
//  Copyright © 2015 du. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyTimePickerDelegate

- (void)timeSelected:(int)minute;

@end


@interface MyTimePicker : UIView <UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPickerView *m_pickerView;
    NSMutableArray *m_arrayData;
    
    int m_selectedNum;
}

@property(nonatomic, assign) id<MyTimePickerDelegate> delegate;

@end

