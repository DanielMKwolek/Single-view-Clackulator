//
//  Calculator.m
//  Calculator
//
//  Created by Daniel Kwolek on 8/25/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

enum theOperation
{
    OperationAddition = 10,
    OperationSubtraction,
    OperationDivision,
    OperationMultiplication,
    OperationClear,
    OperationAllClear,
    OperationEquals,
    OperationOne = 1,
    OperationTwo,
    OperationThree,
    OperationFour,
    OperationFive,
    OperationSix,
    OperationSeven,
    OperationEight,
    OperationNine,
    OperationZero = 0,
    OperationNoCommand
};

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _currentValue = 0;
        _firstValue = 0;
        _secondValue = '\0';
        _storedCommand = nil;
        _firstValue = [[NSMutableArray alloc] init];
        _secondValue = [[NSMutableArray alloc] init];
        _lookAtFirstValue = YES;
    }
    return self;
}


- (NSInteger)doCommand:(NSString *)command
              isnumber:(BOOL)isnumber
{
    
    
    
    
    
    if (isnumber)
    {
        if (_lookAtFirstValue)
        {
            [_firstValue addObject:[NSString stringWithFormat:@"%@", @([command integerValue])]];
            NSString *tempString = [_firstValue componentsJoinedByString:@""];
            _currentValue = [tempString integerValue];
        } else
        {
            [_secondValue addObject:[NSString stringWithFormat:@"%@", @([command integerValue])]];
            NSString *tempString = [_secondValue componentsJoinedByString:@("")];
            _currentValue = [tempString integerValue];
        }
    }
    
    if (!isnumber)
    {
        if ([command isEqualToString:@"C"])
        {
            _commandValue = OperationClear;
        }
        if ([command isEqualToString:@"AC"])
        {
            _commandValue = OperationAllClear;
        }
        if ([command isEqualToString:@"+"])
        {
            _commandValue = OperationAddition;
        }
        if ([command isEqualToString:@"-"])
        {
            _commandValue = OperationSubtraction;
        }
        if ([command isEqualToString:@"/"])
        {
            _commandValue = OperationDivision;
        }
        if ([command isEqualToString:@"="])
        {
            _commandValue = OperationEquals;
        }
        if ([command isEqualToString:@"X"])
        {
            _commandValue = OperationMultiplication;
        }
    }
    
    
    
    
    
    
    switch (_commandValue)
    {
        case (OperationAddition):
        {
            _storedCommand = [NSString stringWithFormat:@"%@", @(OperationAddition)];
            _storedCommandMirror = @"+";
            _lookAtFirstValue = NO;
            break;
        }
        case (OperationSubtraction):
        {
            _storedCommand = [NSString stringWithFormat:@"%@", @(OperationSubtraction)];
            _storedCommandMirror = @"-";
            _lookAtFirstValue = NO;
            break;
        }
        case (OperationDivision):
        {
            _storedCommand = [NSString stringWithFormat:@"%@", @(OperationDivision)];
            _storedCommandMirror = @"/";
            _lookAtFirstValue = NO;
            break;
        }
        case (OperationMultiplication):
        {
            _storedCommand = [NSString stringWithFormat:@"%@", @(OperationMultiplication)];
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
                [_firstValue addObject:@(_currentValue)];
            } else
            {
                [_secondValue removeAllObjects];
                [_secondValue addObject:@(_currentValue)];
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
            [_firstValue addObject:@(_currentValue)];
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
                _storedCommand = @"0";
                _commandValue = '\0';
                break;
            }
            switch ([_storedCommand integerValue])
            {
                case (OperationAddition):
                {
                    NSString *tempString = [_firstValue componentsJoinedByString:@""];
                    NSString *tempStringTwo = [_secondValue componentsJoinedByString:@""];
                    _currentValue = ([tempString integerValue] + [tempStringTwo integerValue]);
                    break;
                }
                case (OperationSubtraction):
                {
                    NSString *tempString = [_firstValue componentsJoinedByString:@""];
                    NSString *tempStringTwo = [_secondValue componentsJoinedByString:@""];
                    _currentValue = ([tempString integerValue] - [tempStringTwo integerValue]);
                    break;
                }
                case (OperationMultiplication):
                {
                    NSString *tempString = [_firstValue componentsJoinedByString:@""];
                    NSString *tempStringTwo = [_secondValue componentsJoinedByString:@""];
                    _currentValue = ([tempString integerValue] * [tempStringTwo integerValue]);
                    break;
                }
                case (OperationDivision):
                {
                    NSString *tempString = [_firstValue componentsJoinedByString:@""];
                    NSString *tempStringTwo = [_secondValue componentsJoinedByString:@""];
                    _currentValue = ([tempString integerValue] / [tempStringTwo integerValue]);
                    if (_currentValue == 0 && ([tempString doubleValue] >= ([tempStringTwo doubleValue] / 2)))
                    {
                        _currentValue++;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            [_secondValue removeAllObjects];
            [_firstValue removeAllObjects];
            [_firstValue addObject:@(_currentValue)];
            _commandValue = '\0';
            _storedCommand = 0;
            break;
        }
        default:
        {
            break;
        }
            
    }
    return _currentValue;
}


@end


// ([_storedCommand integerValue] == OperationNoCommand)
