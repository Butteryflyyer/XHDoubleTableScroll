//
//  subListCell.m
//  XHtableViewGestureDemo
//
//  Created by 信昊 on 2018/9/26.
//  Copyright © 2018年 信昊. All rights reserved.
//

#import "subListCell.h"
#import "baseTableView.h"
@interface subListCell()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign)BOOL fingerIsTouch;

@end

@implementation subListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 400, 800) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self addSubview:tableview];
    self.subtableView = tableview;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
#pragma mark UIScrollView
//判断屏幕触碰状态
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    self.fingerIsTouch = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
    self.fingerIsTouch = NO;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%lf",scrollView.contentOffset.y);
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        if (!self.fingerIsTouch) {
            return;
        }
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
