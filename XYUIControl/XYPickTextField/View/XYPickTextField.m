//
//  XYPickTextField.m
//  VegetationResearch-IOS
//
//  Created by cugxy on 2018/10/15.
//  Copyright © 2018 cugxy. All rights reserved.
//

#import "XYPickTextField.h"

@interface XYPickTextField()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) UIPickerView      * pickView;
@property (strong, nonatomic) NSMutableArray    * dataArray;

@end

@implementation XYPickTextField
{
    DoneTouched doneAction;
    CancelTouched cancelAction;
}

- (id)initWithFrame:(CGRect)rect {
    self = [super initWithFrame:rect];
    if (self){
        self.dataArray = [@[] mutableCopy];
        self.borderStyle=UITextBorderStyleRoundedRect;
        //设置背景颜色，会覆盖上面圆角矩形默认的白色背景
        self.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:0.97];

    }
    return self;
}

- (void)addDataArray:(NSArray *)newDataArray {
    for(id data in newDataArray) {
        [self.dataArray addObject:data];
    }
}

- (void)creatPickerViewWithDoneAction:(DoneTouched)doneA cancelAction:(CancelTouched)cancelA{
    doneAction = doneA;
    cancelAction = cancelA;
    CGFloat width = self.inputView.bounds.size.width;
    CGFloat height = self.inputView.bounds.size.height;
    self.pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    self.pickView.showsSelectionIndicator = YES;
    self.pickView.backgroundColor = [UIColor whiteColor];
    UIToolbar  *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, width, 44)];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                               target:self
                                                                               action:@selector(doneTouched:)];
    doneButton.title = @"确定";
    UIBarButtonItem *cancleButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                 target:self
                                                                                 action:@selector(cancleTouched:)];
    cancleButton.title = @"取消";
    [toolBar setItems:[NSArray arrayWithObjects:cancleButton,
                       [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                    target:nil
                                                                    action:nil],
                       doneButton,
                       nil]];
    self.inputView = self.pickView;
    self.inputAccessoryView = toolBar;
}

#pragma Mark -- UIPickerViewDataSource、
/**
 *  UIPickerViewDataSource 委托函数 pickView列数
 *
 *  @param pickerView UIPickerView
 */
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}
/**
 *  UIPickerViewDataSource 委托函数 pickView 行数
 *
 *  @param pickerView UIPickerView
 *  @param component NSInteger
 */
- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

#pragma Mark -- UIPickerViewDelegate
/**
 *  UIPickerViewDelegate 委托函数 每列宽度
 *
 *  @param pickerView UIPickerView
 *  @param component NSInteger
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 150;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
}

/**
 * UIPickerViewDelegate 委托函数 返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
 *
 *  @param pickerView UIPickerView
 *  @param row NSInteger
 *  @param component NSInteger
 */
- (NSString*)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component {
    return [self.dataArray objectAtIndex:row];
}

#pragma mark -键盘 toolBarBarItem的方法
/**
 * UIBarButtonItem 响应函数
 */
-(void)doneTouched:(UIBarButtonItem *)sender{
    //将textField的第一响应取消
    [self resignFirstResponder];
    NSInteger row = [self.pickView selectedRowInComponent:0];
    [self setText:[self.dataArray objectAtIndex:row]];
    doneAction(sender);
}
/**
 * UIBarButtonItem 响应函数
 */
-(void)cancleTouched:(UIBarButtonItem *)sender{
    //将textField的第一响应取消
    [self resignFirstResponder];
    cancelAction(sender);
}

@end
