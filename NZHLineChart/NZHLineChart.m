//
//  NZHLineChart.m
//  NZHLineChart
//
//  Created by iiyumewo on 16/1/7.
//  Copyright © 2016年 iiyumewo. All rights reserved.
//

#import "NZHLineChart.h"

#define LABEL_TEXTCOLOR label.textColor = [UIColor blackColor]

#define kColorRGB(r, g, b, a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]



#define BOTTOM_MARGIN 17

@interface NZHLineChart ()


@end

@implementation NZHLineChart

- (NSArray *)yLabelValueArray {
    if (_yLabelValueArray == nil) {
        _yLabelValueArray = [NSArray array];
    }
    return _yLabelValueArray;
}
- (NSArray *)xLabelValueArray {
    if (_xLabelValueArray == nil) {
        _xLabelValueArray = [NSArray array];
    }
    return _xLabelValueArray;
}

- (NSMutableArray *)turningPointArray {
    if (_turningPointArray == nil) {
        _turningPointArray = [NSMutableArray array];
    }
    return _turningPointArray;
}

- (NSArray *)valueArray {
    if (_valueArray == nil) {
        _valueArray = [NSArray array];
    }
    return _valueArray;
}

- (NSArray *)lineDataArray {
    if (_lineDataArray == nil) {
        _lineDataArray = [NSArray array];
    }
    return _lineDataArray;
}




- (instancetype)initWithFrame:(CGRect)frame withTopMargin:(CGFloat)topMargin leftAndRightMargin:(CGFloat)LRMargin xLabelArray:(NSArray *)xArray yLabelArray:(NSArray *)yArray chartStyle:(NZHLineChartStyle)lineChartStyle yMaxValue:(CGFloat)yMax yMinValue:(CGFloat)yMin {
    self = [self initWithFrame:frame];
    if (self) {
        self.lineChartStyle = lineChartStyle;
        self.topMargin = topMargin;
        self.leftAndRightMargin = LRMargin;
        self.xLabelValueArray = xArray;
        self.yLabelValueArray = yArray;
        self.yMaxValue = yMax;
        self.yMinValue = yMin;
        self.verticalPaintableAreaWidth = CGRectGetHeight(self.frame)-self.topMargin-BOTTOM_MARGIN;
        self.horizontalPaintableAreaHeight = CGRectGetWidth(self.frame)-2*self.leftAndRightMargin;
    }
    return self;
}
- (void)setLinesData:(NSArray *)lineDataArray {
    self.lineDataArray = lineDataArray;
}

- (void)creatLabelOnXY {
    
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self drawCoordinate:ctx];
    /**
     *  draw turning lines
     *
     */
    if (_lineDataArray != nil) {
        [self drawTurningLines:ctx];
        [self drawTurningPoints:ctx];
    }
}

- (void)drawCoordinate:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 1.0);
    CGContextSetStrokeColorWithColor(ctx, kColorRGB(224, 224, 224, 1).CGColor);
    
    /**
     *  draw horizontal lines
     *
     */
    for (NSInteger i = 0; i < self.yLabelValueArray.count; i++) {
        if (i == 0 || i == self.yLabelValueArray.count-1) {
            CGContextSetLineWidth(ctx, 0.5);
        }else {
            CGContextSetLineWidth(ctx, 0.5);
        }
        CGFloat verticalDistancePerRow = self.verticalPaintableAreaWidth/(self.yLabelValueArray.count-1);
        CGFloat y = self.topMargin+verticalDistancePerRow*i;
        CGContextMoveToPoint(ctx, self.leftAndRightMargin, y);
        CGContextAddLineToPoint(ctx, CGRectGetWidth(self.frame)-self.leftAndRightMargin, y);
        CGContextClosePath(ctx);
        CGContextStrokePath(ctx);
        /**
         *  create labels
         *
         */
        if (i > 0 && i < (self.yLabelValueArray.count-1)) {
            CGRect rect = CGRectMake(self.leftAndRightMargin, y, 100, 10);
            UILabel *label = [[UILabel alloc]initWithFrame:rect];
            LABEL_TEXTCOLOR;
            label.font = [UIFont systemFontOfSize:10];
            label.backgroundColor = [UIColor clearColor];
            label.text = self.yLabelValueArray[self.yLabelValueArray.count-1-i];
            [self addSubview:label];
        }
    }
    
    /**
     *  draw vertical lines
     *
     */
    for (NSInteger i = 0; i < self.xLabelValueArray.count; i++) {
        if (i == 0 || i == self.xLabelValueArray.count-1) {
            CGContextSetLineWidth(ctx, 0.5);
        }else {
            CGContextSetLineWidth(ctx, 0.5);
        }
        CGFloat horizontalDistancePerRank = self.horizontalPaintableAreaHeight/(self.xLabelValueArray.count-1);
        CGFloat x = self.leftAndRightMargin+i*horizontalDistancePerRank;
        CGContextMoveToPoint(ctx, x, self.topMargin);
        CGContextAddLineToPoint(ctx, x, CGRectGetHeight(self.frame)-BOTTOM_MARGIN);
        CGContextClosePath(ctx);
        CGContextStrokePath(ctx);
        /**
         *  create labels
         */
        UILabel *label = [[UILabel alloc]init];
        CGRect rect;
        if (i == 0) {
            rect = CGRectMake(x, CGRectGetHeight(self.frame)-BOTTOM_MARGIN, 100, 10);
            label = [[UILabel alloc]initWithFrame:rect];
        }else if (i == self.xLabelValueArray.count-1) {
            rect = CGRectMake(x-100, CGRectGetHeight(self.frame)-BOTTOM_MARGIN, 100, 10);
            label = [[UILabel alloc]initWithFrame:rect];
            label.textAlignment = NSTextAlignmentRight;
        }else {
            rect = CGRectMake(x-50, CGRectGetHeight(self.frame)-BOTTOM_MARGIN, 100, 10);
            label = [[UILabel alloc]initWithFrame:rect];
            label.textAlignment = NSTextAlignmentCenter;
        }
            LABEL_TEXTCOLOR;
            label.font = [UIFont systemFontOfSize:10];
            label.backgroundColor = [UIColor clearColor];
            label.text = self.xLabelValueArray[i];
        [self addSubview:label];
    }
}

- (NSMutableArray *)recordAllTurningPoints:(NSArray *)valueArray {
    NSMutableArray *turningPointArray = [NSMutableArray array];
    for (NSInteger i = 0; i < valueArray.count; i++) {
        CGFloat value = [valueArray[i] floatValue];
        CGFloat ratioLength = value/self.yMaxValue*self.verticalPaintableAreaWidth;
        CGFloat y = self.topMargin+self.verticalPaintableAreaWidth-ratioLength;
        CGFloat x = self.horizontalPaintableAreaHeight/(valueArray.count-1)*i+self.leftAndRightMargin;
        NSValue *point = [NSValue valueWithCGPoint:CGPointMake(x, y)];
        [turningPointArray addObject:point];
    }
    return turningPointArray;
}

- (void)drawTurningLines:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 1.0);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    for (NZHLineChartData *singleLineData in self.lineDataArray) {
        CGContextSetStrokeColorWithColor(ctx, singleLineData.lineColor.CGColor);
        [singleLineData.linePointArray enumerateObjectsUsingBlock:^(NSValue *pointValue, NSUInteger idx, BOOL *stop) {
            CGPoint point = [pointValue CGPointValue];
            if (idx == 0) {
                
            }else if (idx != 0) {
                CGPoint lastPoint = [singleLineData.linePointArray[idx-1] CGPointValue];
                CGContextMoveToPoint(ctx, lastPoint.x, lastPoint.y);
                CGContextAddLineToPoint(ctx, point.x, point.y);
                CGContextClosePath(ctx);
                CGContextStrokePath(ctx);
            }
        }];
    }
}

- (void)drawTurningPoints:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 2.0);
    for (NZHLineChartData *singleLineData in self.lineDataArray) {
        [singleLineData.linePointArray enumerateObjectsUsingBlock:^(NSValue *pointValue, NSUInteger idx, BOOL *stop) {
            CGPoint point = [pointValue CGPointValue];
            NSInteger pointStyle = [singleLineData.pointStyleArray[idx] intValue];
            if (pointStyle == 0) {
                
            }else if (pointStyle == 1) {
                CGContextSetStrokeColorWithColor(ctx, kColorRGB(127, 140, 141, 1).CGColor);
                CGContextAddArc(ctx, point.x, point.y, 3.f, 0, 2*M_PI, 1);
                CGContextClosePath(ctx);
                CGContextStrokePath(ctx);
                CGContextAddArc(ctx, point.x, point.y, 2.f, 0, 2*M_PI, 1);
                CGContextClosePath(ctx);
                CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
                CGContextFillPath(ctx);
            }else if (pointStyle == 2) {
                CGContextSetStrokeColorWithColor(ctx, kColorRGB(0, 0, 0, 1).CGColor);
                CGContextMoveToPoint(ctx, point.x-5, point.y);
                CGContextAddLineToPoint(ctx, point.x+5, point.y);
                CGContextClosePath(ctx);
                CGContextMoveToPoint(ctx, point.x, point.y-5);
                CGContextAddLineToPoint(ctx, point.x, point.y+5);
                CGContextClosePath(ctx);
                CGContextStrokePath(ctx);
            }
        }];
         
    }
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
