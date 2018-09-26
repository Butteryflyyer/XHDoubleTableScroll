//
//  ViewController.m
//  XHtableViewGestureDemo
//
//  Created by 信昊 on 2018/9/26.
//  Copyright © 2018年 信昊. All rights reserved.
//

#import "ViewController.h"
#import "baseTableView.h"
#import "subListCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)baseTableView *tableView;

@property(nonatomic,strong)subListCell *subcell;

@property(nonatomic,assign)BOOL canScroll;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    baseTableView *tableview = [[baseTableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    self.tableView = tableview;
    self.canScroll = YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark notify
- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;
    self.subcell.vcCanScroll = NO;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"2"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"2"];
        }
        cell.textLabel.text = @"222222";
        return cell;
    }else{
        subListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"3"];
        if (!cell) {
             cell = [[subListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"3"];
        }
        self.subcell = cell;
        return cell;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
        header.backgroundColor = [UIColor grayColor];
        return header;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 ) {
        return 0.001;
    }
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 200;
    }
    return CGRectGetHeight(self.view.bounds);
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat bottom = [self.tableView rectForSection:1].origin.y;
//    NSLog(@"%lf",bottom);
    if (scrollView.contentOffset.y>=bottom) {//当subcell还没有滚动到
        scrollView.contentOffset = CGPointMake(0, bottom);
        if (self.canScroll) {
            self.canScroll = NO;
            self.subcell.vcCanScroll = YES;
            NSLog(@"11111111111");
        }
    }else{
        if (!self.canScroll) {//子cell没到顶
            scrollView.contentOffset = CGPointMake(0, bottom);
            NSLog(@"222222222222");
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
