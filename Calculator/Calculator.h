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
@property (nonatomic, strong)NSMutableArray *firstValue;
@property (nonatomic, strong)NSMutableArray *secondValue;
@property (nonatomic)BOOL lookAtFirstValue;
@property (nonatomic)NSInteger storedCommand;
@property (nonatomic, strong)NSString *storedCommandMirror;
@property (nonatomic)NSInteger commandValue;
@property (nonatomic)BOOL viewclear;

- (void)calculate:(BOOL)dividebyzero;
- (void)doCommand:(NSInteger)operationval
              isnumber:(BOOL)isnumber;

@end
