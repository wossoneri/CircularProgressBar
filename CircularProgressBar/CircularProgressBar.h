//
//  CircularProgressBar.h
//  CircularProgressBar
//
//  Created by du on 10/8/15.
//  Copyright © 2015 du. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularProgressBar : UIView
{
    CGFloat startAngle;
    CGFloat endAngle;
    int     totalTime;
    
    UIFont *textFont;
    UIColor *textColor;
    NSMutableParagraphStyle *textStyle;
}

@property(nonatomic)CGFloat time_left;

- (void)setTotalTime:(CGFloat)time;

@end
