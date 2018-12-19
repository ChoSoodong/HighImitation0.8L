//
//  SDTableView.m
//  test1218
//
//  Created by xialan on 2018/12/18.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import "SDTableView.h"

@implementation SDTableView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
        // 1.判断当前控件能否接收事件
        if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01){
    
            return nil;
        }
        // 2. 判断点在不在当前控件
        if ([self pointInside:point withEvent:event] == NO){
    
            return nil;
        }
        // 3.从后往前遍历自己的子控件，将事件传递给子控件
        NSInteger count = self.subviews.count;
        for (NSInteger i = count - 1; i >= 0; i--) {
            UIView *childView = self.subviews[i];
            // 把当前控件上的坐标系转换成子控件上的坐标系
            CGPoint childP = [self convertPoint:point toView:childView];
            UIView *fitView = [childView hitTest:childP withEvent:event];
            if (fitView) {
                //NSLog(@"%@",fitView);
                // 寻找到响应事件的子控件
                return fitView;
            }
        }
        // 循环结束,表示没有比自己更合适的view
        return self;
        
    
    
}

//让自身这个手势事件响应优先级低于其它手势事件
//只是在对于比它响应优先级低的手势调用
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer  {
    
    if (otherGestureRecognizer.view == self) {
        return YES;
    }
    return NO;
}

//共存  A手势或者B手势 代理方法里shouldRecognizeSimultaneouslyWithGestureRecognizer   有一个是返回YES，就能共存
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (otherGestureRecognizer.view == self) {
        return YES;
    }
    
    return NO;
}


@end
