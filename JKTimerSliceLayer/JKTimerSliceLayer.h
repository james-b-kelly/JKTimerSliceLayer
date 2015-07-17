//
//  JKTimerSliceLayer.h
//  WorkoutApp
//
//  Created by Jamie on 11/4/15.
//  Copyright (c) 2015 James Kelly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKTimerSliceLayer : CALayer

@property (nonatomic, readwrite) CGFloat animationDuration;

@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic) CGFloat strokeWidth;
@property (nonatomic, strong) UIColor *strokeColor;

@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat endAngle;
@property (nonatomic, readwrite) CGFloat innerRadius;
@property (nonatomic, readwrite) CGFloat thickness;

@property (nonatomic, readwrite) CGFloat innerMargin;
@property (nonatomic, readwrite) CGFloat outerMargin;
@end
