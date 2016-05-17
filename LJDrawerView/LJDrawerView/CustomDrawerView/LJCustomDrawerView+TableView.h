//
//  LJCustomDrawerView+TableView.h
//  LJDrawerView
//
//  Created by 罗金 on 16/5/9.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LJCustomDrawerView_TableViewDelegate <NSObject>

/*
 * 抽屉弹窗协议方法，将选中值回传给前一页面
 * selectedName：选中项名称，传参也可改为字典
 */
- (void)CustomDrawerViewSelectedForwardBinWithIndex:(NSInteger)selectedIndex;

@end

@interface LJCustomDrawerView_TableView : UIView

@property (nonatomic, weak) id<LJCustomDrawerView_TableViewDelegate> delegate;

/** 是否展示弹窗 */
@property (nonatomic, assign) BOOL showPopTable;

/** 选中行IndexPath */
@property (nonatomic, assign) NSIndexPath *selectedIndexPath;

/*
 * 初始化折叠抽屉弹窗
 * array：将要展示列表的数组
 */
- (instancetype)initWithFrame:(CGRect)frame andDrawerArray:(NSMutableArray *)array;


@end
