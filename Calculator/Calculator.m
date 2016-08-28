//
//  Calculator.m
//  Calculator
//
//  Created by Daniel Kwolek on 8/25/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

#import "Calculator.h"

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
    
    if (_viewClear)
    {
        _firstValue = '\0';
        _viewClear = NO;
    }
    _divideByZero = NO;
    if (isnumber)
    {
        
        if (_lookAtFirstValue)
        {
            _firstValue = [[[NSString stringWithFormat:@"%@", @(_firstValue)] stringByAppendingString:[NSString stringWithFormat:@"%@", @(operationval)]] integerValue];
            _currentValue = _firstValue;
        } else
        {
            _secondValue = [[[NSString stringWithFormat:@"%@", @(_secondValue)] stringByAppendingString:[NSString stringWithFormat:@"%@", @(operationval)]] integerValue];
        }
    } else
    {
        switch (operationval)
        {
            case (OperationAddition):
            {
                _storedCommand = OperationAddition;
                _storedCommandMirror = @"+";
                _lookAtFirstValue = NO;
                break;
            }
            case (OperationSubtraction):
            {
                _storedCommand = OperationSubtraction;
                _storedCommandMirror = @"-";
                _lookAtFirstValue = NO;
                break;
            }
            case (OperationDivision):
            {
                _storedCommand = OperationDivision;
                _storedCommandMirror = @"/";
                _lookAtFirstValue = NO;
                break;
            }
            case (OperationMultiplication):
            {
                _storedCommand = OperationMultiplication;
                _storedCommandMirror = @"X";
                _lookAtFirstValue = NO;
                break;
            }
            case (OperationClear):
            {
                _currentValue = 0;
                if (_lookAtFirstValue)
                {
                    _firstValue = 0;
                } else
                {
                    _secondValue = 0;
                }
                _storedCommandMirror = @"";
                _commandValue = '\0';
                break;
            }
            case (OperationAllClear):
            {
                _firstValue = 0;
                _secondValue = '\0';
                _currentValue = 0;
                _lookAtFirstValue = YES;
                _storedCommandMirror = @"";
                _commandValue = '\0';
                break;
            }
            case (OperationEquals):
            {
                _storedCommandMirror = @"=";
                if (_lookAtFirstValue)
                {
                    _storedCommand = 0;
                    _commandValue = '\0';
                    break;
                }
                [self calculate:_divideByZero];
                _storedCommand = 0;
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

    switch (_storedCommand)
    {
        case (OperationAddition):
        {
            _currentValue = _firstValue + _secondValue;
            break;
        }
        case (OperationSubtraction):
        {
            _currentValue = _firstValue - _secondValue;
            break;
        }
        case (OperationMultiplication):
        {
            _currentValue = _firstValue * _secondValue;
            break;
        }
        case (OperationDivision):
        {
            if (_secondValue == 0)
            {
                _divideByZero = YES;
            } else
            {
                _currentValue = _firstValue / _secondValue;
                if (_currentValue == 0 && (_firstValue >= _secondValue / 2))
                {
                    _currentValue++;
                }
            }
            break;
        }
        default:
        {
            break;
        }
    }
    if (_divideByZero)
    {
        _firstValue = 0;
        _secondValue = '\0';
        _viewClear = YES;
    } else
    {
        _firstValue = 0;
        _secondValue = '\0';
        _firstValue += _currentValue;
    }
}


@end


// ([_storedCommand integerValue] == OperationNoCommand)
