# NZHLineChart

NZHLineChart is a highly customizable line chart tool, and easy to modify the code.

## Install
1. Download all the files in the `NZHLineChart`.
2. Add the source files folder to your Xcode project.
3. Include wherever you need it with `#import "NZHLineChart.h"`.

## Usage
1. A simple initialization with several frame configuration:
```Objective-C
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
```

2. Draw a line with a value array consisted with NSNumber instances:
```Objective-C
    NZHLineChartData *line1 = [[NZHLineChartData alloc]initWithLineValueArray:[self generateValueArray] forLineChart:lineChart];
    line1.lineColor = kColorWithRGB(101, 50, 0, 1);
    NSMutableArray *zeroArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 100; i++) {
        [zeroArray addObject:@0];
    }
    line1.pointStyleArray = zeroArray;
```
![NZHLineChartSingle]
(https://github.com/iiyumewo/NZHLineChart/blob/master/ReadMe/NZHLineChartSingle.gif?raw=true)

3. Add more line into the line array of the chart:
```Objective-C
    NZHLineChartData *line2 = [[NZHLineChartData alloc]initWithLineValueArray:[self generateValueArray] forLineChart:lineChart];
    line2.lineColor = kColorWithRGB(255, 102, 0, 1);
    line2.pointStyleArray = zeroArray;
    
    NZHLineChartData *line3 = [[NZHLineChartData alloc]initWithLineValueArray:[self generateValueArray] forLineChart:lineChart];
    line3.lineColor = kColorWithRGB(51, 103, 153, 1);
    line3.pointStyleArray = zeroArray;
    [lineChart setLinesData:@[line1, line2, line3]];
```
![NZHLineChartThree]
(https://github.com/iiyumewo/NZHLineChart/blob/master/ReadMe/NZHLineChartThree.gif?raw=true)
