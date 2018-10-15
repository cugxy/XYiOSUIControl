//
//  XYPickTextField.h
//  VegetationResearch-IOS
//
//  Created by cugxy on 2018/10/15.
//  Copyright © 2018 cugxy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DoneTouched)(UIBarButtonItem *);
typedef void(^CancelTouched)(UIBarButtonItem *);

@interface XYPickTextField : UITextField

/*
 * init function
 */
- (id)initWithFrame:(CGRect)rect;

/*
 * 设置 pickView 数据
 *
 * param: newDataArray
 *
 */
- (void)addDataArray:(NSArray *)newDataArray;

/*
 * 创建pickView
 *
 * param: doneA   函数指针 选定时调用
 * param: cancelA 函数指针 取消时调用
 *
 */
- (void)creatPickerViewWithDoneAction:(DoneTouched)doneA cancelAction:(CancelTouched)cancelA;

@end

NS_ASSUME_NONNULL_END
