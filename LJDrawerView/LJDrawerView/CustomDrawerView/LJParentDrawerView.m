//
//  LJParentDrawerView.m
//  LJDrawerView
//
//  Created by 罗金 on 16/5/10.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

#import "LJParentDrawerView.h"

@interface LJParentDrawerView ()

@property (nonatomic, strong) UITableView *drawerTable;

@end

@implementation LJParentDrawerView

@synthesize showPopTable = _showPopTable;

- (instancetype)initWithFrame:(CGRect)frame andDrawerArray:(NSMutableArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBAColor(0, 0, 0, 0.4);
    }
    return self;
}

#pragma mark - Setter && Getter 方法
- (void)setShowPopTable:(BOOL)showPopTable {
    _showPopTable = showPopTable;
    __weak LJParentDrawerView *weakSelf = self;
    
    if (OneTableView) {
        if (showPopTable) {
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            [UIView animateWithDuration:EF_DURATIONTIME animations:^{
                weakSelf.drawerTable.frame = CGRectMake(0, 0, WIDTH, _popTableViewHeight);
                weakSelf.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
            } completion:^(BOOL finished) {
            }];
            
        } else {
            [UIView animateWithDuration:EF_DURATIONTIME animations:^{
                weakSelf.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
                weakSelf.drawerTable.frame = CGRectMake(0, 0, WIDTH, 0);
            } completion:^(BOOL finished) {
                [weakSelf.drawerTable reloadData];
                [weakSelf removeFromSuperview];
            }];
            
        }

    } else if (DoubleTableView) {
        
    }
    
    /*
     * 是否展示列表
     */
//    if (_showPopTable) {
//        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//        [UIView animateWithDuration:EF_DURATIONTIME animations:^{
//            weakSelf.drawerTable.frame = CGRectMake(0, 0, TABLEWIDTH, _popTableViewHeight);
//            weakSelf.classView.frame = CGRectMake(_drawerTable.frame.size.width, 0,  WIDTH-TABLEWIDTH, _drawerTable.frame.size.height);
//            weakSelf.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//        } completion:^(BOOL finished) {
//        }];
//        
//    } else {
//        [UIView animateWithDuration:EF_DURATIONTIME animations:^{
//            weakSelf.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//            weakSelf.drawerTable.frame = CGRectMake(0, 0, TABLEWIDTH, 0);
//            weakSelf.classView.frame = CGRectMake(_drawerTable.frame.size.width, 0,  WIDTH-TABLEWIDTH, _drawerTable.frame.size.height);
//        } completion:^(BOOL finished) {
//            [weakSelf.drawerTable reloadData];
//            [weakSelf removeFromSuperview];
//        }];
//        
//    }
}

- (BOOL)showPopTable {
    return _showPopTable;
}


@end
