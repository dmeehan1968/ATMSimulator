//
//  ATMController.m
//  ATMSimulator
//
//  Created by Dave Meehan on 04/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import "ATMController.h"
#import <MAKVONotificationCenter.h>

NSString * const ATMControllerMessageNotAvailable = @"Not Available";
NSString * const ATMControllerMessageEnterCashBalance = @"Please Enter Initial Cash Balance";

@implementation ATMController

-(void)resetATM {
	
	self.operatorSwitch.state = NO;
	self.console.message = ATMControllerMessageNotAvailable;
	self.console.inputOptions = @[];
	
}

-(void)setConsole:(id<ATMConsole>)console {

	if (_console == console) {
		return;
	}
	
	_console = console;
	
	[self resetATM];
}

-(void)setOperatorSwitch:(id<ATMOperatorSwitch>)operatorSwitch {

	if (_operatorSwitch == operatorSwitch) {
		return;
	}
	
	[_operatorSwitch removeObserver:self keyPath:@"state"];
	
    _operatorSwitch = operatorSwitch;
    
	[_operatorSwitch addObserver:self keyPath:@"state" options:0 block:^(MAKVONotification *notification) {
		
		if (self.operatorSwitch.state) {
			
			self.console.message = ATMControllerMessageEnterCashBalance;
			self.console.inputOptions = @[ @"10,000", @"1,000", @"100", @"10", @"Done" ];
			
		} else {
			
			// Need to guard against recursion.
			static BOOL inReset = NO;

			if (! inReset) {
				inReset = YES;
				[self resetATM];
				inReset = NO;
			}
			
		}
	}];
	
	[self resetATM];
}

@end
