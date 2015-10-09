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
    m_circularProgressBar = [[CircularProgressBar alloc] initWithFrame:self.view.bounds];
    [m_circularProgressBar setTotalTime:100];
    [self.view addSubview:m_circularProgressBar];
}

- (void)viewDidAppear:(BOOL)animated {
    m_timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(setProgress) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setProgress {
    if (m_circularProgressBar.time_left > 0) {
        m_circularProgressBar.time_left -= 0.05;
        [m_circularProgressBar setNeedsDisplay];
    } else {
        [m_timer invalidate];
        m_timer = nil;
    }
}

@end
