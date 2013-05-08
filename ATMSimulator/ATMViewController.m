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
	
}

-(void)viewWillAppear:(BOOL)animated {
	
	[self.atmController setUp];
	
	self.operatorSwitchUI.on = self.operatorSwitch.state;
	
	[super viewWillAppear: animated];
	
}

-(void)viewWillDisappear:(BOOL)animated {
	
	[self.atmController tearDown];
	
	[super viewWillDisappear:animated];
	
}

#pragma mark - ATM Controller

-(void)setupAtmController {
	
	self.atmController = [ATMController new];
	self.atmController.console = self.console = [[ATMConsole alloc] initWithDelegate:self];
	self.atmController.operatorSwitch = self.operatorSwitch = [ATMOperatorSwitch new];
	
}

- (IBAction)didChangeValueForOperatorSwitchUI:(id)sender {

	self.operatorSwitch.state = ((UISwitch *)sender).isOn;
	
}

-(void)console:(ATMConsole *)console didChangeMessage:(NSString *)message {
	
	self.messageUI.text = message;
	
}

@end



