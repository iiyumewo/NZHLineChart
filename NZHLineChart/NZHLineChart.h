//
//  NZHLineChart.h
//  NZHLineChart
//
//  Created by iiyumewo on 16/1/7.
//  Copyright © 2016年 iiyumewo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZHLineChartData.h"

typedef NS_ENUM(NSUInteger, NZHLineChartStyle) {
    NZHLineChartStyleGrid = 0,
};

@interface NZHLineChart : UIView

@property (nonatomic, assign) CGFloat topMargin;
@property (nonatomic, assign) CGFloat leftAndRightMargin;

@property (nonatomic, strong) NSArray *yLabelValueArray;
@property (nonatomic, strong) NSArray *xLabelValueArray;
@property (nonatomic, assign) NZHLineChartStyle lineChartStyle;

@property (nonatomic, assign) CGFloat yMaxValue;
@property (nonatomic, assign) CGFloat yMinValue;
@property (nonatomic, strong) NSMutableArray *turningPointArray;
@property (nonatomic, strong) NSArray *valueArray;

@property (nonatomic, assign) CGFloat horizontalPaintableAreaHeight;
@property (nonatomic, assign) CGFloat verticalPaintableAreaWidth;

@property (nonatomic, strong) NSArray *lineDataArray;

- (instancetype)initWithFrame:(CGRect)frame withTopMargin:(CGFloat)topMargin leftAndRightMargin:(CGFloat)LRMargin xLabelArray:(NSArray *)xArray yLabelArray:(NSArray *)yArray chartStyle:(NZHLineChartStyle)lineChartStyle yMaxValue:(CGFloat)yMax yMinValue:(CGFloat)yMin;

- (void)setLinesData:(NSArray *)lineDataArray;


@end
