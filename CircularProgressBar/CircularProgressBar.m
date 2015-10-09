//
//  CircularProgressBar.m
//  CircularProgressBar
//
//  Created by du on 10/8/15.
//  Copyright © 2015 du. All rights reserved.
//

#define RADIUS 100
#define POINT_RADIUS 8
#define CIRCLE_WIDTH 4
#define PROGRESS_WIDTH 4

#import "CircularProgressBar.h"
#import "TimeHelper.h"

@implementation CircularProgressBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initData];
        [self initView];
    }
    return self;
    
}

- (void)initData {
    // 圆周为 2 * pi * R, 默认起始点于正右方向为 0 度， 改为正上为起始点
    startAngle = -0.5 * M_PI;
    endAngle = startAngle;
    
    totalTime = 0;
    
    textFont = [UIFont fontWithName: @"Helvetica Neue" size: 70];
    textColor = [UIColor lightGrayColor];
    textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    textStyle.alignment = NSTextAlignmentCenter;
}

- (void)initView {
    self.backgroundColor = [UIColor darkGrayColor];
    
}

- (void)drawRect:(CGRect)rect {
    
    endAngle = (1 - self.time_left / totalTime) * 2 * M_PI + startAngle;
    
//    NSString *textContent = [NSString stringWithFormat:@"%2.2f", self.time_left];
    NSString *textContent = [TimeHelper formatTimeWithSecond:self.time_left];
    
    UIBezierPath *circle = [UIBezierPath bezierPath];
    [circle addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:RADIUS
                      startAngle:0
                        endAngle:2 * M_PI
                       clockwise:YES];
    circle.lineWidth = CIRCLE_WIDTH;
    [[UIColor lightGrayColor] setStroke];
    [circle stroke];

    
    UIBezierPath *progress = [UIBezierPath bezierPath];
    [progress addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:RADIUS
                      startAngle:startAngle
                        endAngle:endAngle
                       clockwise:YES];
    progress.lineWidth = PROGRESS_WIDTH;
//    [[UIColor redColor] setStroke];
    [[UIColor redColor] set];
    [progress stroke];
    
    CGPoint pos = [self getCurrentPointAtAngle:endAngle inRect:rect];
    [self drawPointAt:pos];
    
//    [[UIColor blackColor] setFill];
    
    
    CGSize textSize = [textContent sizeWithAttributes:@{NSFontAttributeName:textFont}];
    
    CGRect textRect = CGRectMake(rect.size.width / 2 - textSize.width / 2,
                                 rect.size.height / 2 - textSize.height / 2,
                                 textSize.width , textSize.height);
    
    [textContent drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont, NSForegroundColorAttributeName:textColor, NSParagraphStyleAttributeName:textStyle}];
    
}

- (CGPoint)getCurrentPointAtAngle:(CGFloat)angle inRect:(CGRect)rect {
    //画个图就知道怎么用角度算了
    CGFloat y = sin(angle) * RADIUS;
    CGFloat x = cos(angle) * RADIUS;
    
    CGPoint pos = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    pos.x += x;
    pos.y += y;
    return pos;
}

- (void)drawPointAt:(CGPoint)point {

    UIBezierPath *dot = [UIBezierPath bezierPath];
    [dot addArcWithCenter:CGPointMake(point.x, point.y)
                        radius:POINT_RADIUS
                    startAngle:0
                      endAngle:2 * M_PI
                     clockwise:YES];
    dot.lineWidth = 1;
//    [[UIColor redColor] setFill];
    [dot fill];

    
    
}

- (void)setTotalTime:(CGFloat)time {
    totalTime = time;
    self.time_left = totalTime;
}

@end
