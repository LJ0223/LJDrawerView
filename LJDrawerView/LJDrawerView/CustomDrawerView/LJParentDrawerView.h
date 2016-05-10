//
//  LJParentDrawerView.h
//  LJDrawerView
//
//  Created by 罗金 on 16/5/10.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OneTableView,
    DoubleTableView,
} DRAWERENUM;

@interface LJParentDrawerView : UIView

/** 是否展示弹窗 */
@property (nonatomic, assign) BOOL showPopTable;
@property (nonatomic, assign) CGFloat popTableViewHeight;


- (instancetype)initWithFrame:(CGRect)frame andDrawerArray:(NSMutableArray *)array;

@end
