//
//  ATMController.m
//  ATMSimulator
//
//  Created by Dave Meehan on 04/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import "ATMController.h"

NSString * const ATMControllerMessageNotAvailable = @"Not Available";
NSString * const ATMControllerMessageEnterCashBalance = @"Please Enter Initial Cash Balance";

@implementation ATMController

-(void)setConsole:(id<ATMConsole>)console {
	
	_console = console;
	
	[_console setMessage:ATMControllerMessageNotAvailable];
	
}

-(void)setOperatorSwitch:(id<ATMOperatorSwitch>)operatorSwitch {

	if (_operatorSwitch) {
        [(id)_operatorSwitch removeObserver: self forKeyPath: @"state"];
    }
    
    _operatorSwitch = operatorSwitch;
    
    if (_operatorSwitch) {
        [(id)_operatorSwitch addObserver: self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
        _operatorSwitch.state = _operatorSwitch.state;
    }

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    id state = [change valueForKey:NSKeyValueChangeNewKey];
    
    if ([state boolValue]) {
		[self.console setMessage:ATMControllerMessageEnterCashBalance];
	} else {
		[self.console setMessage:ATMControllerMessageNotAvailable];
	}
    
    
}

@end
