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

-(void)setUp {

	[self.console setMessage:ATMControllerMessageNotAvailable];
	
	[self.operatorSwitch addObserver:self keyPath:@"state" options:NSKeyValueObservingOptionNew block:^(MAKVONotification *notification) {
		
		[self.console setMessage: self.operatorSwitch.state ? ATMControllerMessageEnterCashBalance : ATMControllerMessageNotAvailable];
		
	}];
	
/*    if (self.operatorSwitch) {
        [(id)self.operatorSwitch addObserver: self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
        self.operatorSwitch.state = self.operatorSwitch.state;
    }
*/
}

-(void)tearDown {
	
//	[(id)self.operatorSwitch removeObserver: self forKeyPath: @"state"];
	
	[self.operatorSwitch removeObserver:self keyPath:@"state"];
}



-(void)setOperatorSwitch:(id<ATMOperatorSwitch>)operatorSwitch {

	if (_operatorSwitch) {
//        [(id)_operatorSwitch removeObserver: self forKeyPath: @"state"];
		[_operatorSwitch removeObserver:self keyPath:@"state"];

    }
    
    _operatorSwitch = operatorSwitch;
    
}
/*
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    id state = [change valueForKey:NSKeyValueChangeNewKey];
    
    if ([state boolValue]) {
		[self.console setMessage:ATMControllerMessageEnterCashBalance];
	} else {
		[self.console setMessage:ATMControllerMessageNotAvailable];
	}
    
    
}
*/
@end
