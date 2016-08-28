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

@property (nonatomic)NSInteger currentValue;
@property (nonatomic)NSInteger firstValue;
@property (nonatomic)NSInteger secondValue;
@property (nonatomic)BOOL lookAtFirstValue;
@property (nonatomic)NSInteger storedCommand;
@property (nonatomic, strong)NSString *storedCommandMirror;
@property (nonatomic)NSInteger commandValue;
@property (nonatomic)BOOL viewClear;
@property (nonatomic)BOOL divideByZero;

- (void)calculate:(BOOL)dividebyzero;
- (void)doCommand:(NSInteger)operationval
              isnumber:(BOOL)isnumber;

@end
