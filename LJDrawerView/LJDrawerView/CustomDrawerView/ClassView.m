//
//  ClassView.m
//  eleDemo
//
//  Created by 罗金 on 16/3/9.
//  Copyright © 2016年 罗金. All rights reserved.
//

#import "ClassView.h"
#import "LJDrawerDoubleTable.h"

@interface ClassView()<UITableViewDataSource, UITableViewDelegate>


@end

@implementation ClassView

@synthesize indexArray = _indexArray;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self classTable];
    }
    return self;
}

#pragma mark - tableView Delegate && DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _indexArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Identyfier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dic = _indexArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"cell显示内容：%@", [_indexArray[indexPath.row] objectForKey:@"name"]);
    LJDrawerDoubleTable *superVIew = (LJDrawerDoubleTable *)self.superview;
    superVIew.showPopTable = NO;
    
    /** 将选中下标传回前台页面 */
    if (superVIew.delegate && [superVIew.delegate respondsToSelector:@selector(CustomDrawerViewSelectedForwardBinWithIndex:)]) {
        [superVIew.delegate CustomDrawerViewSelectedForwardBinWithIndex:indexPath.row];
    }
}


#pragma mark- getter && setter 方法

- (NSMutableArray *)indexArray
{
    return _indexArray;
}

- (void)setIndexArray:(NSMutableArray *)indexArray
{
    _indexArray = [NSMutableArray arrayWithArray:indexArray];
    
    // 刷新classTable的数据源
    [self.classTable reloadData];
}


#pragma mark- LayoutUI

- (UITableView *)classTable
{
    if (!_classTable) {
        _classTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _classTable.delegate = self;
        _classTable.dataSource = self;
        _classTable.tableFooterView = [[UIView alloc] init];
        _classTable.backgroundColor = [UIColor clearColor];
        _classTable.separatorStyle = NO;
        [self addSubview:_classTable];
    }
    return _classTable;
}

@end
