//
//  Calculator.h
//  Calculator
//
//  Created by Daniel Kwolek on 8/25/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface Calculator : NSObject

@property (nonatomic, readonly)NSInteger currentValue;
@property (nonatomic, readonly)NSInteger firstValue;
@property (nonatomic, readonly)NSInteger secondValue;
@property (nonatomic, readonly)BOOL lookAtFirstValue;
@property (nonatomic, readonly)NSInteger storedCommand;
@property (nonatomic, readonly, strong)NSString *storedCommandMirror;
@property (nonatomic, readonly)NSInteger commandValue;
@property (nonatomic, readonly)BOOL viewClear;
@property (nonatomic, readonly)BOOL divideByZero;

- (void)calculate:(BOOL)dividebyzero;
- (void)doCommand:(NSInteger)operationval
              isnumber:(BOOL)isnumber;

@end
