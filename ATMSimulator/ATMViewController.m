//
//  ATMViewController.m
//  ATMSimulator
//
//  Created by Dave Meehan on 02/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import "ATMViewController.h"
#import <MAKVONotificationCenter.h>
#import <MTControl/UIControl+MTControl.h>

@implementation ATMViewController
{}

#pragma mark - Lifecycle

-(void)viewDidLoad {

	[self setupAtmController];
	
}

-(void)viewDidAppear:(BOOL)animated {
	
	[self setupOperatorSwitch];
	[self setupConsole];
	
	[super viewDidAppear: animated];
	
}

#pragma mark - ATM Controller

-(void)setupAtmController {
	
	self.atmController = [ATMController new];
	self.atmController.console = self.console = [ATMConsole new];
	self.atmController.operatorSwitch = self.operatorSwitch = [ATMOperatorSwitch new];
	
}

#pragma mark - Operator Switch

-(void)setupOperatorSwitch {

	__weak ATMViewController *weakSelf = self;
	
	[self.operatorSwitch addObservationKeyPath:@"state" options:0 block:^(MAKVONotification *notification) {
		
		weakSelf.operatorSwitchUI.on = weakSelf.operatorSwitch.state;
		
	}];
	
	[self.operatorSwitchUI valueChanged:^(UIEvent *event) {
		
		self.operatorSwitch.state = self.operatorSwitchUI.isOn;
		
	}];

	self.operatorSwitch.state = self.operatorSwitch.state;
}

#pragma mark - Console

-(void)setupConsole {
	
	__weak ATMViewController *weakSelf = self;
	
	[self.console addObservationKeyPath:@"message" options:0 block:^(MAKVONotification *notification) {
		
		weakSelf.messageUI.text = weakSelf.console.message;
		
	}];

	self.console.message = self.console.message;
	
}

@end



