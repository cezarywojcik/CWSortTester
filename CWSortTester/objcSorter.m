//
//  objcSorter.m
//  CWSortTester
//
//  Created by Cezary Wojcik on 6/5/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

#import "objcSorter.h"

@implementation objcSorter

+ (void)bubbleSort:(NSArray *)arr {
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

@end
