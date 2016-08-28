//
//  ViewController.m
//  Calculator
//
//  Created by Daniel Kwolek on 8/25/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

#import "ViewController.h"
#import "Calculator.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *firstNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *answerLabel;
@property (strong, nonatomic) IBOutlet UILabel *commandLabel;
@property (strong, nonatomic) Calculator *calculator;
- (IBAction)operationButtonPressed:(UIButton *)sender;
- (IBAction)numberButtonPressed:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *Cbutton;


enum Operation
{
    OperationAddition = 1,
    OperationSubtraction,
    OperationDivision,
    OperationMultiplication,
    OperationClear,
    OperationAllClear,
    OperationEquals,
};


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _calculator = [[Calculator alloc] init];
    [self screenRender:_calculator];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)screenRender:(Calculator *)calculator
{
    [self.firstNumberLabel setText:[calculator.firstValue componentsJoinedByString:@""]];
    [self.answerLabel setText:[calculator.secondValue componentsJoinedByString:@""]];
    [self.commandLabel setText:calculator.storedCommandMirror];
    if (
        ((self.calculator.lookAtFirstValue == YES && [self.firstNumberLabel.text integerValue] == 0) && (self.firstNumberLabel.text.length <= 1))
        ||
        ((self.calculator.lookAtFirstValue == NO && [self.answerLabel.text integerValue] == 0) && (self.answerLabel.text.length <= 1))
        )
    {
        [self.Cbutton setHidden:YES];
    } else
    {
        [self.Cbutton setHidden:NO];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)operationButtonPressed:(UIButton *)sender
{
    NSInteger opVal;
    
    switch ([sender.titleLabel.text characterAtIndex:0])
    {
        case '+':
        {
            opVal = OperationAddition;
            break;
        }
        case 'X':
        {
            opVal = OperationMultiplication;
            break;
        }
        case '-':
        {
            opVal = OperationSubtraction;
            break;
        }
        case '/':
        {
            opVal = OperationDivision;
            break;
        }
        case '=':
        {
            opVal = OperationEquals;
            break;
        }
        case 'C':
        {
            opVal = OperationClear;
            break;
        }
        case 'A':
        {
            opVal = OperationAllClear;
            break;
        }
        default:
            break;
    }
    
    
    [_calculator doCommand:opVal isnumber:NO];
    [self screenRender:_calculator];
}

- (IBAction)numberButtonPressed:(UIButton *)sender
{
    
    [_calculator doCommand:[sender.titleLabel.text integerValue] isnumber:YES];
    
    [self screenRender:_calculator];
    
}
@end
