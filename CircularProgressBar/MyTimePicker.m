//
//  MyTimePicker.m
//  CircularProgressBar
//
//  Created by mythware on 10/9/15.
//  Copyright © 2015 du. All rights reserved.
//

#define MAX_ROWS    10000

#import "MyTimePicker.h"

@implementation MyTimePicker

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
    m_selectedNum = 0;
    
    m_arrayData = [NSMutableArray array];
    for (int time = 0; time < 100; time++) {
        [m_arrayData addObject:[NSString stringWithFormat:@"%d", time]];
    }
    
    
    m_pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake((self.frame.size.width - 320) / 2.0,
                                                                  (self.frame.size.height - 216) / 2.0,
                                                                  320.0, 216.0)];
    m_pickerView.delegate = self;
    m_pickerView.dataSource = self;
    m_pickerView.showsSelectionIndicator = YES;
    
    NSInteger  selectedRow = 0;
    [m_pickerView selectRow:(((NSInteger)((MAX_ROWS / 2) / [m_arrayData count])) * [m_arrayData count]) + (selectedRow % [m_arrayData count]) inComponent:0 animated:NO]; //计算就是取MAX_ROWS的中间位置 并取整 如果默认不是起始的0 则加上偏移位置
    
    
    m_label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2.0 + 20,
                                                        self.frame.size.height/ 2.0 - 20,
                                                        60, 40)];
    m_label.text = @"分钟";
    m_label.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    
    [self addSubview:m_pickerView];
    [self addSubview:m_label];
}

- (void)initView {
    self.backgroundColor = [UIColor colorWithRed:0xec / 255.0f
                                           green:0xeb / 255.0f
                                            blue:0xf1 / 255.0f
                                           alpha:1.0f];
    
    
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *circle = [UIBezierPath bezierPath];
    [circle addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                      radius:200
                  startAngle:0
                    endAngle:2 * M_PI
                   clockwise:YES];
    circle.lineWidth = 10;
    [[UIColor whiteColor] setStroke];
    [circle stroke];

}

#pragma mark - picker delegate
-(NSArray *)pickerViewAnimalAtIndexes:(NSIndexSet *)indexes
{
    return nil;
}

//返回滚轮中row的样式
-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return nil;
}

//返回滚轮的row的高度
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

#pragma mark - picker dataSource
//返回滚轮的数量
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //原来为了显示 “分钟” 使用2列滑轮的方法，在第二列显示 “分钟”，
    //但其有拖动效果，和系统的不一样。
    //所以为了解决这个问题，采用放一个label的方法固定显示，label的坐标需要调整好
//    return 2;
    return 1;
}


//当row被选中的时候
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    NSLog(@"第%d个row被选中", row % [m_arrayData count]);
    if (delegate) {
        [delegate timeSelected:(int)row % [m_arrayData count]];
    }
}

//返回滚轮的row数量
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        //        return [m_arrayData count];
        return MAX_ROWS;
    } else {
        return 1;
    }
}



//返回row显示的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //    return [m_arrayData objectAtIndex:row];
    if (component == 0) {
        return [m_arrayData objectAtIndex:(row % [m_arrayData count])];
    }
    else {
        return @"分钟";
    }
}

/*
 注意，该方法只有当需要使用，需要自定义row的视图的时候，才能重写，并且返回一个具体的视图，如果返回一个nil，那么将会导致不现实row的内容，因为row的视图为nil
 //自定义row的view
 -(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
 {
 return nil;
 }
 
 */

//返回滚轮的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 60;
}

@end

