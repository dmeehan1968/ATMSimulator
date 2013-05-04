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
{}

#pragma mark - Lifecycle

-(void)viewDidLoad {

	[self setupAtmController];
	[self setupOperatorSwitch];
	[self setupConsole];
	
}

#pragma mark - ATM Controller

-(void)setupAtmController {
	
	self.atmController = [ATMController new];
	
}

#pragma mark - Operator Switch

-(void)setupOperatorSwitch {
	
	self.operatorSwitch = [ATMOperatorSwitch new];
	self.atmController.operatorSwitch = self.operatorSwitch;
	self.operatorSwitchUI.on = self.operatorSwitch.state;

}

- (IBAction)didChangeValueForOperatorSwitchUI:(id)sender {

	self.operatorSwitch.state = ((UISwitch *)sender).isOn;
	
}

#pragma mark - Console

-(void)setupConsole {
	
	self.console = [ATMConsole new];
	
}

@end



