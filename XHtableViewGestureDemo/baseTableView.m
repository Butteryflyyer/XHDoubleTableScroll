//
//  baseTableView.m
//  XHtableViewGestureDemo
//
//  Created by 信昊 on 2018/9/26.
//  Copyright © 2018年 信昊. All rights reserved.
//

#import "baseTableView.h"

@implementation baseTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
