//
//  NZHLineChartData.m
//  NZHLineChart
//
//  Created by iiyumewo on 16/1/8.
//  Copyright © 2016年 iiyumewo. All rights reserved.
//

#import "NZHLineChartData.h"
#import "NZHLineChart.h"

@interface NZHLineChartData ()

@property (nonatomic, strong) NZHLineChart *lineChart;

@end

@implementation NZHLineChartData

- (NSArray *)linePointArray {
    if (_linePointArray == nil) {
        _linePointArray = [NSArray array];
    }
    return _linePointArray;
}

- (UIColor *)lineColor {
    if (_lineColor == nil) {
        _lineColor = [UIColor whiteColor];
    }
    return _lineColor;
}

- (NSArray *)lineValueArray {
    if (_lineValueArray == nil) {
        _lineValueArray = [NSArray array];
    }
    return _lineValueArray;
}

- (NSArray *)pointStyleArray {
    if (_pointStyleArray == nil) {
        _pointStyleArray = [NSArray array];
    }
    return _pointStyleArray;
}






- (instancetype)initWithLineValueArray:(NSArray *)lineValueArray forLineChart:(NZHLineChart *)lineChart {
    self = [super init];
    if (self) {
        self.lineValueArray = lineValueArray;
        self.lineChart = lineChart;
        self.linePointArray = [self recordAllTurningPoints:self.lineValueArray];
    }
    return self;
}

- (NSMutableArray *)recordAllTurningPoints:(NSArray *)valueArray {
    NSMutableArray *turningPointArray = [NSMutableArray array];
    for (NSInteger i = 0; i < valueArray.count; i++) {
        CGFloat value = [valueArray[i] floatValue];
        CGFloat ratioLength = value/self.lineChart.yMaxValue*self.lineChart.verticalPaintableAreaWidth;
        CGFloat y = self.lineChart.topMargin+self.lineChart.verticalPaintableAreaWidth-ratioLength;
        CGFloat x = self.lineChart.horizontalPaintableAreaHeight/(valueArray.count-1)*i+self.lineChart.leftAndRightMargin;
        NSValue *point = [NSValue valueWithCGPoint:CGPointMake(x, y)];
        [turningPointArray addObject:point];
    }
    return turningPointArray;
}

- (void)setTurningPointStyle:(NZHLineTurningPointStyle)style andWhichPoints:(NSArray *)numberArray {
    
}

@end
