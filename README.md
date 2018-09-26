# XHDoubleTableScroll
tableview嵌套滑动的解决方案
tableView中嵌套tableView的滑动解决方案。



```
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
```
先看这个方法，这个方法是支持多手势交互的。

我这里用的对于两个tableview通信，用的是通知。
```
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
```
首先分析主tableView.
结构是这样的。2个section。第一个section有两个cell，第二个section有一个cell然后里面嵌套了tableView。
```
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
```
获取第二个section在tableview中的位置，当subtableview滚动的时候，保持scrollView.contentOffset.y为第二个section的y值。

然后我们再来看subtableview中
```
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

```
首先第一点，当vccanscroll为false的情况下，subtableview的scrollview.contenoffset一直未0.
当 scrollview.contenoffset .y大于0的情况下，正常滚动。
当 scrollview.contenoffset .y小于等于0的情况下，发送通知，通知主tableView可以滚动。

以上就是重点内容。
