//
//  ATM.m
//  ATMSimulator
//
//  Created by Dave Meehan on 03/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import "ATM.h"

@implementation ATM
{
	BOOL _inService;
	CGFloat _cashBalance;
}

-(void)setConsole:(id<ATMConsole>)console {
    
    _console = console;
    _console.message = @"Not Available";
    
}

-(void)setInService:(BOOL)inService {
	
	_inService = inService;
	
	if (_inService) {
		
		self.console.message = @"Enter Initial Cash Balance";

	} else {
		
		self.console.message = @"Not Available";

	}
	
}

-(void)setCashBalance:(CGFloat)cashBalance {
    
    _cashBalance = cashBalance;
    
    self.console.message = @"Please Insert Card";
    
}
@end
