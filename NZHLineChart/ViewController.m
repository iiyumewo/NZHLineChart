//
//  ViewController.m
//  NZHLineChart
//
//  Created by iiyumewo on 2016/12/9.
//  Copyright © 2016年 iiyumewo. All rights reserved.
//

#import "ViewController.h"
#import "NZHLineChart.h"

#define kColorWithRGB(r, g, b, a) [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:a]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(0, 30, self.view.frame.size.width, 119);
    NZHLineChart *lineChart = [[NZHLineChart alloc]initWithFrame:rect
                                                withTopMargin:1
                                           leftAndRightMargin:18
                                                     xLabelArray:@[@"0", @"50", @"100"]
                                                  yLabelArray:@[@"0", @"50", @"100"]
                                                   chartStyle:NZHLineChartStyleGrid
                                                    yMaxValue:100
                                                    yMinValue:0];
    lineChart.backgroundColor = [UIColor whiteColor];
    
    
    
    NZHLineChartData *line1 = [[NZHLineChartData alloc]initWithLineValueArray:[self generateValueArray] forLineChart:lineChart];
    line1.lineColor = kColorWithRGB(101, 50, 0, 1);
    NSMutableArray *zeroArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 100; i++) {
        [zeroArray addObject:@0];
    }
    line1.pointStyleArray = zeroArray;
    
    NZHLineChartData *line2 = [[NZHLineChartData alloc]initWithLineValueArray:[self generateValueArray] forLineChart:lineChart];
    line2.lineColor = kColorWithRGB(255, 102, 0, 1);
    line2.pointStyleArray = zeroArray;
    NZHLineChartData *line3 = [[NZHLineChartData alloc]initWithLineValueArray:[self generateValueArray] forLineChart:lineChart];
    line3.lineColor = kColorWithRGB(51, 103, 153, 1);
    line3.pointStyleArray = zeroArray;
    [lineChart setLinesData:@[line1, line2, line3]];
    
    [self.view addSubview:lineChart];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSMutableArray *)generateValueArray {
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSInteger i=0; i<100; i++) {
        NSInteger value = arc4random()%101;
        [valueArray addObject:[NSNumber numberWithInteger:value]];
    }
    return valueArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
