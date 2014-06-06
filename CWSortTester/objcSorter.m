//
//  objcSorter.m
//  CWSortTester
//
//  Created by Cezary Wojcik on 6/5/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

#import "objcSorter.h"

@implementation objcSorter

+ (void)bubbleSort:(NSArray *)arr
{
    NSMutableArray *result = [arr mutableCopy];
    NSUInteger numSwaps = 0;
    do {
        numSwaps = 0;
        for (NSUInteger i = 0; i < [arr count] - 1; i++) {
            if ([[result objectAtIndex:i] integerValue] > [[result objectAtIndex:i + 1] integerValue]) {
                [result exchangeObjectAtIndex:i withObjectAtIndex:(i + 1)];
                numSwaps++;
            }
        }
    } while (numSwaps != 0);
}

+ (void)quickSort:(NSArray *)arr left:(NSInteger)left right: (NSInteger)right
{
    NSMutableArray *result = [arr mutableCopy];
    if (right > left) {
        NSInteger i = left;
        for (NSInteger j = left + 1; j < right + 1; j++) {
            if ([result objectAtIndex:j] < [result objectAtIndex:left]) {
                i++;
                [result exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
        [result exchangeObjectAtIndex:i withObjectAtIndex:left];
        [self quickSort:result left:left right:i - 1];
        [self quickSort:result left:i + 1 right:right];
    }
}

+ (void)nativeSort:(NSArray *)arr
{
    [arr sortedArrayUsingSelector:@selector(compare:)];
}

@end
