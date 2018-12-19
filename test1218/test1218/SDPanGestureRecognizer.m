//
//  SDPanGestureRecognizer.m
//  test1218
//
//  Created by xialan on 2018/12/18.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import "SDPanGestureRecognizer.h"

@implementation SDPanGestureRecognizer

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent*)event{
    [super touchesBegan:touches withEvent:event];
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.inView];
    self.beginPoint= point;
    
}

-(instancetype)initWithTarget:(id)target action:(SEL)action inview:(UIView*)view{
    self= [super initWithTarget:target action:action];
    if(self) {
        self.inView = view;
        
    }
    return self;
    
}


@end


