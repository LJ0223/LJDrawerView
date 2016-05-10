//
//  ClassView.h
//  eleDemo
//
//  Created by 罗金 on 16/3/9.
//  Copyright © 2016年 罗金. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 此处就是一个自定义的View，自定义的View一部分功能与ViewController一样，可以在自定义View上添加TableView，并遵循其协议方法，TableView的布局展示跟在ViewController上一样
 */
@interface ClassView : UIView

@property (nonatomic, strong) NSMutableArray *indexArray;

@end
