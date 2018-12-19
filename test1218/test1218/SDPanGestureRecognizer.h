//
//  SDPanGestureRecognizer.h
//  test1218
//
//  Created by xialan on 2018/12/18.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDPanGestureRecognizer : UIPanGestureRecognizer

/** <#  #> */
@property (nonatomic, assign) CGPoint beginPoint;

/** <#  #> */
@property (nonatomic, strong) UIView *inView;

-(instancetype)initWithTarget:(id)target action:(SEL)action inview:(UIView*)view;

@end

NS_ASSUME_NONNULL_END
