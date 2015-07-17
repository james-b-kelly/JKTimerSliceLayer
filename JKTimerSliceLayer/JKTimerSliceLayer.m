//
//  JKTimerSliceLayer.m
//  WorkoutApp
//
//  Created by Jamie on 11/4/15.
//  Copyright (c) 2015 James Kelly. All rights reserved.
//

#import "JKTimerSliceLayer.h"
#import <QuartzCore/QuartzCore.h>

@implementation JKTimerSliceLayer
@dynamic startAngle, endAngle, innerRadius, thickness, strokeWidth, strokeColor, fillColor, innerMargin, outerMargin, animationDuration;

-(CABasicAnimation *)makeAnimationForKey:(NSString *)key {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:key];
    anim.fromValue = [[self presentationLayer] valueForKey:key];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    if (self.animationDuration == 0.0) {
        self.animationDuration = 0.26;
    }
    anim.duration = self.animationDuration;
    return anim;
}

- (id)init {
    self = [super init];
    if (self) {
        self.fillColor = [UIColor darkGrayColor];
        self.strokeColor = [UIColor lightGrayColor];
        self.strokeWidth = 1.0;
        
        self.contentsScale = [UIScreen mainScreen].scale;
        [self setNeedsDisplay];
    }
    
    return self;
}

-(id<CAAction>)actionForKey:(NSString *)event {
    if ([event isEqualToString:@"startAngle"] ||
        [event isEqualToString:@"endAngle"]) {
        return [self makeAnimationForKey:event];
    }
    
    return [super actionForKey:event];
}

- (id)initWithLayer:(id)layer {
    if (self = [super initWithLayer:layer]) {
        if ([layer isKindOfClass:[JKTimerSliceLayer class]]) {
            JKTimerSliceLayer *other = (JKTimerSliceLayer *)layer;
            self.startAngle = other.startAngle;
            self.endAngle = other.endAngle;
            self.fillColor = other.fillColor;
        }
    }
    
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"startAngle"] || [key isEqualToString:@"endAngle"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}


-(void)drawInContext:(CGContextRef)ctx {
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat innerRadius = self.innerRadius + self.innerMargin;
    CGFloat outerRadius = self.innerRadius + self.thickness -  self.outerMargin;
    
    CGPoint p1Inner = CGPointMake(center.x + innerRadius * cosf(self.startAngle),
                                  center.y + innerRadius * sinf(self.startAngle));
    CGPoint p2Outer = CGPointMake(center.x + outerRadius * cosf(self.endAngle),
                                  center.y + outerRadius * sinf(self.endAngle));
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, p1Inner.x, p1Inner.y);
    CGContextAddArc(ctx, center.x, center.y, innerRadius, self.startAngle, self.endAngle, 0);
    CGContextAddLineToPoint(ctx, p2Outer.x, p2Outer.y);
    CGContextAddArc(ctx, center.x, center.y, outerRadius, self.endAngle, self.startAngle, 1);
    CGContextSetFillColorWithColor(ctx, [self.fillColor colorWithAlphaComponent:1.0].CGColor);
    CGContextSetStrokeColorWithColor(ctx, self.strokeColor.CGColor);
    CGContextSetLineWidth(ctx, self.strokeWidth);
    CGContextDrawPath(ctx, kCGPathFill);
}
@end
