//
//  objcSorter.h
//  CWSortTester
//
//  Created by Cezary Wojcik on 6/5/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface objcSorter : NSObject

+ (void)bubbleSort:(NSArray *)arr;
+ (void)quickSort:(NSArray *)arr left:(NSInteger)left right: (NSInteger)right;
+ (void)nativeSort:(NSArray *)arr;

@end
