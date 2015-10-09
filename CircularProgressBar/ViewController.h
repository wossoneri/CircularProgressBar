//
//  ViewController.h
//  CircularProgressBar
//
//  Created by du on 10/8/15.
//  Copyright © 2015 du. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularProgressBar.h"
#import "CustomIOSAlertView.h"
#import "MyTimePicker.h"

@interface ViewController : UIViewController <CircularProgressDelegate, CustomIOSAlertViewDelegate, MyTimePickerDelegate>
{
    CircularProgressBar *m_circularProgressBar;
    NSTimer *m_timer;
    int m_timeSelected;
}

@end

