//
//  CircularProgressBar.m
//  CircularProgressBar
//
//  Created by du on 10/8/15.
//  Copyright © 2015 du. All rights reserved.
//

#define RADIUS 200
#define POINT_RADIUS 8
#define CIRCLE_WIDTH 4
#define PROGRESS_WIDTH 4
#define TEXT_SIZE 140
#define TIMER_INTERVAL 0.05

#import "CircularProgressBar.h"
#import "TimeHelper.h"

@implementation CircularProgressBar

@synthesize delegate;

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
    
    textFont = [UIFont fontWithName: @"Helvetica Neue" size: TEXT_SIZE];
    textColor = [UIColor blackColor];
    textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    textStyle.alignment = NSTextAlignmentCenter;
    
    b_timerRunning = NO;

}

- (void)initView {
    self.backgroundColor = [UIColor colorWithRed:0xeb / 255.0f
                                           green:0xeb / 255.0f
                                            blue:0xf1 / 255.0f
                                           alpha:1.0f];
}

- (void)drawRect:(CGRect)rect {
    if (totalTime == 0) 
        endAngle = startAngle;
    else
        endAngle = (1 - self.time_left / totalTime) * 2 * M_PI + startAngle;
    
    UIBezierPath *circle = [UIBezierPath bezierPath];
    [circle addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:RADIUS
                      startAngle:0
                        endAngle:2 * M_PI
                       clockwise:YES];
    circle.lineWidth = CIRCLE_WIDTH;
    [[UIColor whiteColor] setStroke];
    [circle stroke];

    
    UIBezierPath *progress = [UIBezierPath bezierPath];
    [progress addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:RADIUS
                      startAngle:startAngle
                        endAngle:endAngle
                       clockwise:YES];
    progress.lineWidth = PROGRESS_WIDTH;
    [[UIColor redColor] set];
    [progress stroke];
    
    CGPoint pos = [self getCurrentPointAtAngle:endAngle inRect:rect];
    [self drawPointAt:pos];
    
//    [[UIColor blackColor] setFill];
    
    //    NSString *textContent = [NSString stringWithFormat:@"%2.2f", self.time_left];
    NSString *textContent = [TimeHelper formatTimeWithSecond:self.time_left];
    
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
    [dot fill];
    
}

- (void)setTotalSecondTime:(CGFloat)time {
    totalTime = time;
    self.time_left = totalTime;
}

- (void)setTotalMinuteTime:(CGFloat)time {
    totalTime = time * 60;
    self.time_left = totalTime;
}

- (void)startTimer {
    if (!b_timerRunning) {
        m_timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(setProgress) userInfo:nil repeats:YES];
        b_timerRunning = YES;
    }
}

- (void)pauseTimer {
    if (b_timerRunning) {
        [m_timer invalidate];
        m_timer = nil;
        b_timerRunning = NO;
    }
}

- (void)setProgress {
    if (self.time_left > 0) {
        self.time_left -= TIMER_INTERVAL;
        [self setNeedsDisplay];
    } else {
        [self pauseTimer];
        
        if (delegate) {
            [delegate CircularProgressEnd];
        }
    }
}

- (void)stopTimer {
    [self pauseTimer];
    
    startAngle = -0.5 * M_PI;
    endAngle = startAngle;
    self.time_left = totalTime;
    [self setNeedsDisplay];

}
@end
