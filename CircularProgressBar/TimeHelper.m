//
//  TimeHelper.m
//  CircularProgressBar
//
//  Created by du on 10/8/15.
//  Copyright © 2015 du. All rights reserved.
//

#import "TimeHelper.h"

@implementation TimeHelper

+ (NSString *)formatTimeWithSecond:(CGFloat)left_time {
//    left_time % 60
    
    NSString *str_sec;
    int sec = (int)ceil(left_time) % 60; //ceil 向上取整
    if (sec < 10) {
        str_sec = [@"0" stringByAppendingString:[NSString stringWithFormat:@"%d", sec]];
    } else {
        str_sec = [NSString stringWithFormat:@"%d", sec];
    }
    
    NSString *str_min;
    int min = (int)ceil(left_time) / 60;
    if (min < 10) {
        str_min = [@"0" stringByAppendingString:[NSString stringWithFormat:@"%d", min]];
    } else {
        str_min = [NSString stringWithFormat:@"%d", min];
    }
    
    NSString *str = [str_min stringByAppendingString:@":"];
    str = [str stringByAppendingString:str_sec];
    return str;
}

@end
