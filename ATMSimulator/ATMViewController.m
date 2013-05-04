//
//  ATMViewController.m
//  ATMSimulator
//
//  Created by Dave Meehan on 02/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import "ATMViewController.h"


@interface ATMViewController ()


@end

@implementation ATMViewController

-(void)viewDidLoad {

	self.atmController = [ATMController new];	
	self.operatorSwitch = [ATMOperatorSwitch new];
	self.atmController.operatorSwitch = self.operatorSwitch;

- (IBAction)didChangeValueForOperatorSwitchUI:(id)sender {

	self.operatorSwitch.state = ((UISwitch *)sender).isOn;
	
}

@end
