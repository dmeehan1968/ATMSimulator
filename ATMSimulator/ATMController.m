//
//  ATMController.m
//  ATMSimulator
//
//  Created by Dave Meehan on 04/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import "ATMController.h"

@implementation ATMController

-(void)setConsole:(id<ATMConsole>)console {
	
	_console = console;
	
	[_console setMessage:@"Not Available"];
	
}

-(void)setOperatorSwitch:(id<ATMOperatorSwitch>)operatorSwitch {
	_operatorSwitch = operatorSwitch;
	
	_operatorSwitch.delegate = self;
	
}
@end
