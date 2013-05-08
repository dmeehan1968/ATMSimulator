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

-(void)setConsole:(id<ATMConsole>)console {
	
	_console = console;
	
	[_console setMessage:ATMControllerMessageNotAvailable];
}

-(void)setOperatorSwitch:(id<ATMOperatorSwitch>)operatorSwitch {

    _operatorSwitch = operatorSwitch;
    
	[_operatorSwitch addObserver:self keyPath:@"state" options:0 block:^(MAKVONotification *notification) {
		
		[self.console setMessage: self.operatorSwitch.state ? ATMControllerMessageEnterCashBalance : ATMControllerMessageNotAvailable];
		
	}];
}

@end
