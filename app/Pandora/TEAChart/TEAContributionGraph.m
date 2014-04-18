//
//  TEAContributionGraph.m
//  Xhacker
//
//  Created by Xhacker on 2013-07-28.
//  Copyright (c) 2013 Xhacker. All rights reserved.
//

#import "TEAContributionGraph.h"
#import "NSDate+TEAExtensions.h"

static const NSInteger kDefaultGradeCount = 5;

@interface TEAContributionGraph ()

@property (nonatomic) NSUInteger gradeCount;
@property (nonatomic, strong) NSMutableArray *gradeMinCutoff;
@property (nonatomic, strong) NSDate *graphMonth;
@property (nonatomic, strong) NSMutableArray *colors;

@end

@implementation TEAContributionGraph

#pragma mark - View lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadDefaults];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self loadDefaults];
    }
    return self;
}

- (void)loadDefaults
{
    // Load one-time data from the delegate
    
    // Get the total number of grades
    if ([_delegate respondsToSelector:@selector(numberOfGrades)]) {
        _gradeCount = [_delegate numberOfGrades];
    }
    else {
        _gradeCount = kDefaultGradeCount;
    }
    
    // Load all of the colors from the delegate
    if ([_delegate respondsToSelector:@selector(colorForGrade:)]) {
        _colors = [[NSMutableArray alloc] initWithCapacity:_gradeCount];
        for (int i = 0; i < _gradeCount; i++) {
            [_colors addObject:[_delegate colorForGrade:i]];
        }
    }
    else {
        // Use the defaults
        _colors = [[NSMutableArray alloc] initWithObjects:
                   [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1],
                   [UIColor colorWithRed:0.839 green:0.902 blue:0.522 alpha:1],
                   [UIColor colorWithRed:0.549 green:0.776 blue:0.396 alpha:1],
                   [UIColor colorWithRed:0.267 green:0.639 blue:0.251 alpha:1],
                   [UIColor colorWithRed:0.118 green:0.408 blue:0.137 alpha:1], nil];
        // Check if there is the correct number of colors
        if (_gradeCount != kDefaultGradeCount) {
            [[NSException exceptionWithName:@"Invalid Data" reason:@"The number of grades does not match the number of colors. Implement colorForGrade: to define a different number of colors than the default 5" userInfo:NULL] raise];
        }
    }
    
    // Get the minimum cutoff for each grade
    if ([_delegate respondsToSelector:@selector(minimumValueForGrade:)]) {
        _gradeMinCutoff = [[NSMutableArray alloc] initWithCapacity:_gradeCount];
        for (int i = 0; i < _gradeCount; i++) {
            // Convert each value to a NSNumber
            [_gradeMinCutoff addObject:@([_delegate minimumValueForGrade:i])];
        }
    }
    else {
        // Use the default values
        _gradeMinCutoff = [[NSMutableArray alloc] initWithObjects:
                           @0,
                           @1,
                           @3,
                           @6,
                           @8, nil];
        
        if (_gradeCount != kDefaultGradeCount) {
            [[NSException exceptionWithName:@"Invalid Data" reason:@"The number of grades does not match the number of grade cutoffs. Implement minimumValueForGrade: to define the correct number of cutoff values" userInfo:NULL] raise];
        }
    }
    
    if ([_delegate respondsToSelector:@selector(monthForGraph)]) {
        _graphMonth = [_delegate monthForGraph];
    }
    else {
        // Use the current month by default
        _graphMonth = [NSDate date];
    }
    

}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_graphMonth];
    comp.day = 1;
    NSDate *firstDay = [calendar dateFromComponents:comp];
    
    comp.month = comp.month + 1;
    NSDate *nextMonth = [calendar dateFromComponents:comp];
    
    NSArray *weekdayNames = @[@"S", @"M", @"T", @"W", @"T", @"F", @"S"];
    [[UIColor colorWithWhite:0.56 alpha:1] setFill];
    NSInteger textHeight = self.width * 1.2;
    for (NSInteger i = 0; i < 7; i += 1) {
        [weekdayNames[i] drawInRect:CGRectMake(i * (self.width + self.spacing), 0, self.width, self.width) withFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:self.width * 0.65] lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
    }
    
    for (NSDate *date = firstDay; [date compare:nextMonth] == NSOrderedAscending; date = [date tea_nextDay]) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comp = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitDay fromDate:date];
        NSInteger weekday = comp.weekday;
        NSInteger weekOfMonth = comp.weekOfMonth;
        NSInteger day = comp.day;
        
        NSInteger grade = 0;
        NSInteger contributions = 0;
        if ([_delegate respondsToSelector:@selector(valueForDay:)]) {
            contributions = [_delegate valueForDay:day];
        }
        
        // Get the grade from the minimum cutoffs
        for (int i = 0; i < _gradeCount; i++) {
            if ([_gradeMinCutoff[i] integerValue] <= contributions) {
                grade = i;
            }
        }
        
        [self.colors[grade] setFill];
        CGRect backgroundRect = CGRectMake((weekday - 1) * (self.width + self.spacing), (weekOfMonth - 1) * (self.width + self.spacing) + textHeight, self.width, self.width);
        CGContextFillRect(context, backgroundRect);
    }
}

#pragma mark Setters

- (void)setWidth:(NSInteger)width
{
    _width = width;
    [self setNeedsDisplay];
}

- (void)setSpacing:(NSInteger)spacing
{
    _spacing = spacing;
    [self setNeedsDisplay];
}

@end
