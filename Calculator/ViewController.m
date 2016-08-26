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


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _calculator = [[Calculator alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)screenRender:(Calculator *)calculator
{
    [self.firstNumberLabel setText:[calculator.firstValue componentsJoinedByString:@""]];
    [self.answerLabel setText:[calculator.secondValue componentsJoinedByString:@""]];
    [self.commandLabel setText:calculator.storedCommandMirror];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (IBAction)operationButtonPressed:(UIButton *)sender {
    
    [_calculator doCommand:sender.titleLabel.text isnumber:NO];
    
    [self screenRender:_calculator];
}

- (IBAction)numberButtonPressed:(UIButton *)sender {
    
    [_calculator doCommand:sender.titleLabel.text isnumber:YES];
    
    
    [self screenRender:_calculator];
    
}
@end
