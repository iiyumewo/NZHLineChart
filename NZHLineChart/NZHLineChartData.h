//
//  NZHLineChartData.h
//  NZHLineChart
//
//  Created by iiyumewo on 16/1/8.
//  Copyright © 2016年 iiyumewo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class NZHLineChart;

typedef NS_ENUM(NSUInteger, NZHLineTurningPointStyle) {
    NZHLineTurningPointStyleNone = 0,
    NZHLineTurningPointStyleRound = 1,
    NZHLineTurningPointStylePlus = 2,
};

@interface NZHLineChartData : NSObject

@property (nonatomic, strong) NSArray *linePointArray;
@property (nonatomic, strong) NSArray *lineValueArray;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) NSArray *pointStyleArray;

- (instancetype)initWithLineValueArray:(NSArray *)lineValueArray forLineChart:(NZHLineChart *)lineChart;

@end
