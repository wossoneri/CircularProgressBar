//
//  ViewController.m
//  CircularProgressBar
//
//  Created by du on 10/8/15.
//  Copyright © 2015 du. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    m_timeSelected = 0;

    m_circularProgressBar = [[CircularProgressBar alloc] initWithFrame:self.view.bounds];
    m_circularProgressBar.delegate = self;
    [m_circularProgressBar setTotalSecondTime:0];
    [self.view addSubview:m_circularProgressBar];
    
    //单击开始
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [m_circularProgressBar setUserInteractionEnabled:YES];
    [m_circularProgressBar addGestureRecognizer:singleTap];
    //双击暂停
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapDetected)];
    doubleTap.numberOfTapsRequired = 2;
    [m_circularProgressBar addGestureRecognizer:doubleTap];
}

- (void)viewDidAppear:(BOOL)animated {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)singleTapDetected{
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    MyTimePicker *timePicker = [[MyTimePicker alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    [timePicker setDelegate:self];
    
    [alertView setContainerView:timePicker];
    [alertView setDelegate:self];
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Done", @"Cancel", nil]];
    [alertView show];

}

- (void)doubleTapDetected {
    [m_circularProgressBar pauseTimer];
}

#pragma mark - progress bar delegate
- (void)CircularProgressEnd {
    [m_circularProgressBar stopTimer];
}

#pragma mark - picker delegate
- (void)timeSelected:(int)minute {
    m_timeSelected = minute;
}

#pragma mark - popup delegate
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [m_circularProgressBar setTotalMinuteTime:m_timeSelected];
        [m_circularProgressBar startTimer];
    }
    [alertView close];
}

@end
