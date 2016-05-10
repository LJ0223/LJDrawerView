//
//  LJCustomDrawerView+TableView.m
//  LJDrawerView
//
//  Created by 罗金 on 16/5/9.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

#import "LJCustomDrawerView+TableView.h"

@interface LJCustomDrawerView_TableView ()<UITableViewDataSource, UITableViewDelegate>

{
    /** 选中行Row */
    NSInteger _selectedRow;
    
    CGFloat _popTableViewHeight;
}

@property (nonatomic, strong) NSMutableArray *drawerArray;
@property (nonatomic, strong) UITableView *drawerTable;

@end

@implementation LJCustomDrawerView_TableView

@synthesize showPopTable = _showPopTable;

static NSString * const customDrawerCellId = @"customDrawerCell";

- (instancetype)initWithFrame:(CGRect)frame andDrawerArray:(NSMutableArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        /** 默认选中第一行 */
        _selectedRow = -1;
        self.backgroundColor = RGBAColor(0, 0, 0, 0.4);
        
        self.drawerArray = [NSMutableArray arrayWithArray:array];
        [self layoutUIs];
    }
    return self;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _drawerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customDrawerCellId];
    cell.selectionStyle = NO;
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    NSDictionary *dic = [_drawerArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];
    
    if (indexPath.row == _selectedRow) {
        cell.imageView.image = [UIImage imageNamed:@"customCheck"];
        cell.textLabel.textColor = GreenColor;
    } else {
        cell.textLabel.textColor = DarkGreyWordsColor;
        cell.imageView.image = nil;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != _selectedRow) {
        _selectedRow = indexPath.row;
        
        /** 将选中下标传回前台页面 */
        if (self.delegate && [self.delegate respondsToSelector:@selector(CustomDrawerViewSelectedForwardBinWithIndex:)]) {
            [self.delegate CustomDrawerViewSelectedForwardBinWithIndex:indexPath.row];
        }
    }
    
    self.showPopTable = NO;
}

#pragma mark - Setter && Getter 方法
- (void)setShowPopTable:(BOOL)showPopTable {
    _showPopTable = showPopTable;
    __weak LJCustomDrawerView_TableView *weakSelf = self;
    
    /*
     * 是否展示列表
     */
    if (_showPopTable) {
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
}

- (BOOL)showPopTable {
    return _showPopTable;
}

#pragma mark - LayoutUIs
- (void)layoutUIs {
    /*
     * 判断tableView的高度，并给_popTableViewHeight高度赋值
     *
     */
    if (self.frame.size.height > 45*_drawerArray.count) {
        _popTableViewHeight = 45*_drawerArray.count;
    } else {
        _popTableViewHeight = self.frame.size.height;
    }
    self.drawerTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 0)];
    
    self.drawerTable.backgroundColor = BackGroundColor;
    self.drawerTable.tableFooterView = [[UIView alloc] init];
    self.drawerTable.rowHeight = 45;
    _drawerTable.delegate = self;
    _drawerTable.dataSource = self;
    
    [self.drawerTable registerClass:[UITableViewCell class] forCellReuseIdentifier:customDrawerCellId];
    [self addSubview:_drawerTable];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.showPopTable = NO;
}
@end
