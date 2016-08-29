//
//  Calculator.m
//  Calculator
//
//  Created by Daniel Kwolek on 8/25/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

#import "Calculator.h"

@interface Calculator()
@property (nonatomic, readwrite)NSInteger currentValue;
@property (nonatomic, readwrite)NSInteger firstValue;
@property (nonatomic, readwrite)NSInteger secondValue;
@property (nonatomic, readwrite)BOOL lookAtFirstValue;
@property (nonatomic, readwrite)NSInteger storedCommand;
@property (nonatomic, readwrite, strong)NSString *storedCommandMirror;
@property (nonatomic, readwrite)NSInteger commandValue;
@property (nonatomic, readwrite)BOOL viewClear;
@property (nonatomic, readwrite)BOOL divideByZero;

@end

@implementation Calculator

enum Operation
{
    OperationNone = 0,
    OperationAddition,
    OperationSubtraction,
    OperationDivision,
    OperationMultiplication,
    OperationClear,
    OperationAllClear,
    OperationEquals
};

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _currentValue = 0;
        _firstValue = 0;
        _secondValue = '\0';
        _storedCommand = OperationNone;
        _lookAtFirstValue = YES;
    }
    return self;
}


- (void)doCommand:(NSInteger)operationval
         isnumber:(BOOL)isnumber
{
    if (self.viewClear)
    {
        self.firstValue = '\0';
        self.viewClear = NO;
    }
    self.divideByZero = NO;
    
    if (isnumber)
    {
        if (self.lookAtFirstValue)
        {
            self.firstValue = [[[NSString stringWithFormat:@"%@", @(self.firstValue)] stringByAppendingString:[NSString stringWithFormat:@"%@", @(operationval)]] integerValue];
            self.currentValue = self.firstValue;
        } else
        {
            self.secondValue = [[[NSString stringWithFormat:@"%@", @(self.secondValue)] stringByAppendingString:[NSString stringWithFormat:@"%@", @(operationval)]] integerValue];
        }
    } else
    {
        switch (operationval)
        {
            case (OperationAddition):
            {
                self.storedCommand = OperationAddition;
                self.storedCommandMirror = @"+";
                self.lookAtFirstValue = NO;
                break;
            }
            case (OperationSubtraction):
            {
                self.storedCommand = OperationSubtraction;
                self.storedCommandMirror = @"-";
                self.lookAtFirstValue = NO;
                break;
            }
            case (OperationDivision):
            {
                self.storedCommand = OperationDivision;
                self.storedCommandMirror = @"/";
                self.lookAtFirstValue = NO;
                break;
            }
            case (OperationMultiplication):
            {
                self.storedCommand = OperationMultiplication;
                self.storedCommandMirror = @"X";
                self.lookAtFirstValue = NO;
                break;
            }
            case (OperationClear):
            {
                self.currentValue = 0;
                if (self.lookAtFirstValue)
                {
                    self.firstValue = 0;
                } else
                {
                    self.secondValue = 0;
                }
                self.storedCommandMirror = @"";
                self.commandValue = '\0';
                break;
            }
            case (OperationAllClear):
            {
                self.firstValue = 0;
                self.secondValue = '\0';
                self.currentValue = 0;
                self.lookAtFirstValue = YES;
                self.storedCommandMirror = @"";
                self.commandValue = '\0';
                break;
            }
            case (OperationEquals):
            {
                self.storedCommandMirror = @"=";
                if (self.lookAtFirstValue)
                {
                    self.storedCommand = 0;
                    self.commandValue = '\0';
                    break;
                }
                [self calculate:self.divideByZero];
                self.storedCommand = 0;
                break;
            }
            default:
            {
                break;
            }
        }
    }
}

- (void)calculate:(BOOL)dividebyzero
{

    switch (self.storedCommand)
    {
        case (OperationAddition):
        {
            self.currentValue = self.firstValue + self.secondValue;
            break;
        }
        case (OperationSubtraction):
        {
            self.currentValue = self.firstValue - self.secondValue;
            break;
        }
        case (OperationMultiplication):
        {
            self.currentValue = self.firstValue * self.secondValue;
            break;
        }
        case (OperationDivision):
        {
            if (self.secondValue == 0)
            {
                self.divideByZero = YES;
            } else
            {
                self.currentValue = self.firstValue / self.secondValue;
                if (self.currentValue == 0 && (self.firstValue >= self.secondValue / 2))
                {
                    self.currentValue++;
                }
            }
            break;
        }
        default:
        {
            break;
        }
    }
    if (self.divideByZero)
    {
        self.firstValue = 0;
        self.secondValue = '\0';
        self.viewClear = YES;
    } else
    {
        self.firstValue = 0;
        self.secondValue = '\0';
        self.firstValue += self.currentValue;
    }
}


@end


// ([self.storedCommand integerValue] == OperationNoCommand)
