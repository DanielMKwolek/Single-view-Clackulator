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
        _firstValue = [[NSMutableArray alloc] init];
        _secondValue = [[NSMutableArray alloc] init];
        _lookAtFirstValue = YES;
    }
    return self;
}


- (void)doCommand:(NSInteger)operationval
         isnumber:(BOOL)isnumber
{
    
    if (_viewclear)
    {
        [_firstValue removeAllObjects];
        _viewclear = NO;
    }
    BOOL _dividebyzero = NO;
    if (isnumber)
    {
        
        if (_lookAtFirstValue)
        {
            
            [_firstValue addObject:[NSString stringWithFormat:@"%@", @(operationval)]];
            _currentValue = [[_firstValue componentsJoinedByString:@""] integerValue];
        } else
        {
            [_secondValue addObject:[NSString stringWithFormat:@"%@", @(operationval)]];
            _currentValue = [[_secondValue componentsJoinedByString:@("")] integerValue];
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
                    [_firstValue removeAllObjects];
                } else
                {
                    [_secondValue removeAllObjects];
                }
                _storedCommandMirror = @"";
                _commandValue = '\0';
                break;
            }
            case (OperationAllClear):
            {
                [_secondValue removeAllObjects];
                [_firstValue removeAllObjects];
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
                [self calculate:_dividebyzero];
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
            _currentValue = ([[_firstValue componentsJoinedByString:@""] integerValue] + [[_secondValue componentsJoinedByString:@""] integerValue]);
            break;
        }
        case (OperationSubtraction):
        {
            _currentValue = ([[_firstValue componentsJoinedByString:@""] integerValue] - [[_secondValue componentsJoinedByString:@""] integerValue]);
            break;
        }
        case (OperationMultiplication):
        {
            _currentValue = ([[_firstValue componentsJoinedByString:@""] integerValue] * [[_secondValue componentsJoinedByString:@""] integerValue]);
            break;
        }
        case (OperationDivision):
        {
            if ([[_secondValue componentsJoinedByString:@""] integerValue] == 0)
            {
                dividebyzero = YES;
            } else
            {
                _currentValue = ([[_firstValue componentsJoinedByString:@""] integerValue] / [[_secondValue componentsJoinedByString:@""] integerValue]);
                if (_currentValue == 0 && ([[_firstValue componentsJoinedByString:@""] doubleValue] >= ([[_secondValue componentsJoinedByString:@""] doubleValue] / 2)))
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
    if (dividebyzero)
    {
        [_secondValue removeAllObjects];
        [_firstValue removeAllObjects];
        [_firstValue addObject:@"Error"];
        _viewclear = YES;
    } else
    {
        [_secondValue removeAllObjects];
        [_firstValue removeAllObjects];
        [_firstValue addObject:@(_currentValue)];
    }
}


@end


// ([_storedCommand integerValue] == OperationNoCommand)
