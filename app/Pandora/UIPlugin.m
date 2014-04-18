//
//  UIPlugin.m
//  PandoraDev
//
//  Created by Wu Moor on 4/17/14.
//
//

#import "UIPlugin.h"
#import "PDRCoreAppFrame.h"
//#import "JSONKit.h"
#import "TEABarChart.h"

@implementation UIPlugin

- (NSData*)drawPie:(PGMethod *)command{
    NSArray *args = command.arguments;
    NSDictionary *dictionary = [args objectAtIndex:0];
    
    NSNumber *x=[dictionary valueForKey:@"x"];
    NSNumber *y=[dictionary valueForKey:@"y"];
    NSNumber *width=[dictionary valueForKey:@"width"];
    NSNumber *height=[dictionary valueForKey:@"height"];
    
    UIScrollView *view=self.JSFrameContext.webView.scrollView;
    
    TEABarChart *barChart = [[TEABarChart alloc] initWithFrame:CGRectMake([x floatValue], [y floatValue], [width floatValue], [height floatValue])];
    barChart.data = @[@2, @7, @9];
//    barChart.data = NSArray init(
    [view addSubview:barChart];
    
    return [self resultWithNull];
}

@end
