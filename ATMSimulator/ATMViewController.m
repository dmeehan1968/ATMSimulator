//
//  ATMViewController.m
//  ATMSimulator
//
//  Created by Dave Meehan on 02/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import "ATMViewController.h"
#import <MAKVONotificationCenter.h>

@interface ATMViewController ()


@end

@implementation ATMViewController
{}

#pragma mark - Lifecycle

-(void)viewDidLoad {

	[self setupAtmController];
	
}

-(void)viewDidAppear:(BOOL)animated {
	
	__weak ATMViewController *weakSelf = self;
	
	[self.operatorSwitch addObservationKeyPath:@"state" options:0 block:^(MAKVONotification *notification) {
		
		weakSelf.operatorSwitchUI.on = weakSelf.operatorSwitch.state;
		
	}];

	[self.console addObservationKeyPath:@"message" options:0 block:^(MAKVONotification *notification) {
		
		weakSelf.messageUI.text = weakSelf.console.message;
		
	}];

	self.operatorSwitch.state = self.operatorSwitch.state;
	self.console.message = self.console.message;
	
	[super viewWillAppear: animated];
	
}

-(void)viewDidDisappear:(BOOL)animated {
	
	[super viewWillDisappear:animated];
	
}

#pragma mark - ATM Controller

-(void)setupAtmController {
	
	self.atmController = [ATMController new];
	self.atmController.console = self.console = [ATMConsole new];
	self.atmController.operatorSwitch = self.operatorSwitch = [ATMOperatorSwitch new];
	
}

- (IBAction)didChangeValueForOperatorSwitchUI:(id)sender {

	self.operatorSwitch.state = ((UISwitch *)sender).isOn;
	
}

@end



