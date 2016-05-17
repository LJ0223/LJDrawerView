//
//  LJDrawerDoubleTable.m
//  LJDrawerView
//
//  Created by 罗金 on 16/5/9.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

#import "LJDrawerDoubleTable.h"

#import "ClassView.h"

#define TABLEWIDTH 100

@interface LJDrawerDoubleTable ()<UITableViewDelegate, UITableViewDataSource>

{
    CGFloat _popTableViewHeight;
}

@property (nonatomic, strong) NSMutableArray *drawerArray;
@property (nonatomic, strong) UITableView *drawerTable;
@property (nonatomic, strong) ClassView *classView;
@property (nonatomic, assign) NSIndexPath *lastIndexPath; // 标记上一次的选中状态

@end

@implementation LJDrawerDoubleTable

@synthesize showPopTable = _showPopTable;

static NSString * const customDrawerCellId = @"customDrawerCell";


- (instancetype)initWithFrame:(CGRect)frame andDrawerArray:(NSMutableArray *)array {
    self = [super initWithFrame:frame];
    if (self) {
        /** 默认选中第一行 */
        self.lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:0] ;

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
    cell.textLabel.text = [NSString stringWithFormat:@"分类：%ld%@", indexPath.row+1, [dic objectForKey:@"name"]];
    
    // 默认第一个cell是选中状态
    if (indexPath == self.lastIndexPath) {
        cell.backgroundColor = [UIColor cyanColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *array = [[_drawerArray objectAtIndex:indexPath.row] objectForKey:@"items"];
    if (array.count == 0) {
        NSLog(@"跳转控制器%ld", indexPath.row);
        self.showPopTable = NO;
        
        /** 将选中下标传回前台页面 */
        if (self.delegate && [self.delegate respondsToSelector:@selector(LJDrawerDoubleTablePushToNextControllerWithTitle:)]) {
            [self.delegate LJDrawerDoubleTablePushToNextControllerWithTitle:[[_drawerArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
        }
        
    } else if (indexPath != self.lastIndexPath) {
        // 改变右侧展示布局
        _classView.indexArray = array;
        
        // 将上一个选中的cell的背景色变为未选中状态
        UITableViewCell *lastCell = [tableView cellForRowAtIndexPath:self.lastIndexPath];
        lastCell.backgroundColor = [UIColor whiteColor];
        
        // 改变选中cell的背景色为选中状态
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor cyanColor];
        
        self.lastIndexPath = indexPath;
        
        
    }

//    self.showPopTable = NO;
}

#pragma mark - Setter && Getter 方法
- (void)setShowPopTable:(BOOL)showPopTable {
    _showPopTable = showPopTable;
    __weak LJDrawerDoubleTable *weakSelf = self;
    
    /*
     * 是否展示列表
     */
    if (_showPopTable) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [UIView animateWithDuration:EF_DURATIONTIME animations:^{
            weakSelf.drawerTable.frame = CGRectMake(0, 0, TABLEWIDTH, _popTableViewHeight);
            weakSelf.classView.frame = CGRectMake(weakSelf.drawerTable.frame.size.width, 0,  WIDTH-TABLEWIDTH, weakSelf.drawerTable.frame.size.height);
            weakSelf.classView.classTable.frame = CGRectMake(0, 0, weakSelf.classView.frame.size.width, weakSelf.classView.frame.size.height);
            weakSelf.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        } completion:^(BOOL finished) {
        }];
        
    } else {
        [UIView animateWithDuration:EF_DURATIONTIME animations:^{
            weakSelf.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            weakSelf.drawerTable.frame = CGRectMake(0, 0, TABLEWIDTH, 0);
            weakSelf.classView.frame = CGRectMake(weakSelf.drawerTable.frame.size.width, 0,  WIDTH-TABLEWIDTH, 0);
            weakSelf.classView.classTable.frame = CGRectMake(0, 0, weakSelf.classView.frame.size.width, 0);
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
        _popTableViewHeight = 30*_drawerArray.count;
    } else {
        _popTableViewHeight = self.frame.size.height;
    }
    self.drawerTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, TABLEWIDTH, 0)];
    
    self.drawerTable.backgroundColor = BackGroundColor;
    self.drawerTable.tableFooterView = [[UIView alloc] init];
    self.drawerTable.rowHeight = 30;
    _drawerTable.delegate = self;
    _drawerTable.dataSource = self;
    
    [self.drawerTable registerClass:[UITableViewCell class] forCellReuseIdentifier:customDrawerCellId];
    [self addSubview:_drawerTable];
    
}

#pragma mark 自定义视图，此处自定义的是TableView，也可以自定义其他视图
- (ClassView *)classView
{
    if (!_classView) {
        _classView = [[ClassView alloc]initWithFrame:CGRectMake(_drawerTable.frame.size.width, 0,  WIDTH-TABLEWIDTH, 0)];
        NSMutableArray *array = [[_drawerArray objectAtIndex:0] objectForKey:@"items"];
        _classView.indexArray = array;
        _classView.backgroundColor = [UIColor redColor];
        [self addSubview:_classView];
    }
    return _classView;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.showPopTable = NO;
}


@end
