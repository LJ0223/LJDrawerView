//
//  CustomDrawerViewController.m
//  LJDrawerView
//
//  Created by 罗金 on 16/5/9.
//  Copyright © 2016年 EasyFlower. All rights reserved.
//

#import "CustomDrawerViewController.h"
#import "LJCustomDrawerView+TableView.h"
#import "LJDrawerDoubleTable.h"

#import "NextViewController.h"

@interface CustomDrawerViewController ()<LJCustomDrawerView_TableViewDelegate, LJDrawerDoubleTableDelegate>

{
    /** 是否有抽屉弹窗已出现，默认没有 */
    BOOL _haveDrawerView;
}

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;

@property (nonatomic, strong) LJCustomDrawerView_TableView *firstDrawerView;
@property (nonatomic, strong) NSMutableArray *firstDrawerArray;

@property (nonatomic, strong) LJDrawerDoubleTable *secondDrawerView;
@property (nonatomic, strong) NSMutableArray *secondDrawerArray;

@end

@implementation CustomDrawerViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSString *path1 = [[NSBundle mainBundle]pathForResource:@"FirstDrawerPList" ofType:@"plist"];
        NSArray *array1 = [NSArray arrayWithContentsOfFile:path1];
        self.firstDrawerArray = [[NSMutableArray alloc] initWithArray:array1];
        
        NSString *path2 = [[NSBundle mainBundle]pathForResource:@"SecondDrawerPList" ofType:@"plist"];
        NSArray *array2 = [NSArray arrayWithContentsOfFile:path2];
        self.secondDrawerArray = [[NSMutableArray alloc] initWithArray:array2];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"仿美团抽屉弹窗";
}

- (IBAction)topBtnAction:(UIButton *)sender {
    if (sender.tag == 1) {
        if (self.firstDrawerView.showPopTable) {
            self.firstDrawerView.showPopTable = NO;
        } else {
            [self showFirstDrawerView];
        }
    } else if (sender.tag == 2) {
        if (self.secondDrawerView.showPopTable) {
            self.secondDrawerView.showPopTable = NO;
        } else {
            [self showSecondDrawerView];
        }
    } else {
        
    }
}

#pragma mark - LJCustomDrawerView_TableViewDelegate
- (void)CustomDrawerViewSelectedForwardBinWithIndex:(NSInteger)selectedIndex {
    NSLog(@"selectedIndex==%ld", selectedIndex);
}

- (void)LJDrawerDoubleTablePushToNextControllerWithTitle:(NSString *)title {
    NextViewController *nextController = [[NextViewController alloc] init];
    nextController.title = title;
    [self.navigationController pushViewController:nextController animated:YES];
}

- (void)showFirstDrawerView {
    if (!_firstDrawerView) {
        self.firstDrawerView = [[LJCustomDrawerView_TableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_firstBtn.frame), WIDTH, HEIGHT-CGRectGetMaxY(_firstBtn.frame)) andDrawerArray:_firstDrawerArray];
        _firstDrawerView.delegate = self;
    }
    
    [self.view.window addSubview:_firstDrawerView];
    self.firstDrawerView.showPopTable = YES;
}

- (void)showSecondDrawerView {
    if (!_secondDrawerView) {
        self.secondDrawerView = [[LJDrawerDoubleTable alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_firstBtn.frame), WIDTH, HEIGHT-CGRectGetMaxY(_firstBtn.frame)) andDrawerArray:_secondDrawerArray];
        _secondDrawerView.delegate = self;
    }
    
    [self.view.window addSubview:_secondDrawerView];
    self.secondDrawerView.showPopTable = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
