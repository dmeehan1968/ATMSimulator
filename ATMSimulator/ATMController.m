//
//  ATMController.m
//  ATMSimulator
//
//  Created by Dave Meehan on 04/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import "ATMController.h"

NSString *ATMControllerMessageNotAvailable = @"Not Available";
NSString *ATMControllerMessageEnterCashBalance = @"Please Enter Initial Cash Balance";

@implementation ATMController

-(void)setConsole:(id<ATMConsole>)console {
	
	_console = console;
	
	[_console setMessage:ATMControllerMessageNotAvailable];
	
}

-(void)setOperatorSwitch:(id<ATMOperatorSwitch>)operatorSwitch {
	_operatorSwitch = operatorSwitch;
	
	_operatorSwitch.delegate = self;
	
}

-(void)operatorSwitch:(id<ATMOperatorSwitch>)operatorSwitch didChangeToState:(BOOL)state {
	
	if (state) {
		[self.console setMessage:ATMControllerMessageEnterCashBalance];
	} else {
		[self.console setMessage:ATMControllerMessageNotAvailable];
	}
}

@end
