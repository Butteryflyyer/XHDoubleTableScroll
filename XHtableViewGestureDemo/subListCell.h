//
//  subListCell.h
//  XHtableViewGestureDemo
//
//  Created by 信昊 on 2018/9/26.
//  Copyright © 2018年 信昊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface subListCell : UITableViewCell
@property(nonatomic,strong)UITableView *subtableView;
@property (nonatomic, assign) BOOL vcCanScroll;
@end
