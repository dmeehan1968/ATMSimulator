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
NSString * const ATMControllerMessageInsertCard = @"Please Insert Card";
NSString * const ATMControllerMessageInvalidInput = @"Invalid Input";

@interface ATMController()

@property (strong, nonatomic) NSArray *cashBalanceInputs;

@end


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

			[self prepareForCashBalanceInput];
			
		} else {
			
			[self endCashBalanceInput];
			
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

-(void)prepareForCashBalanceInput {
	
	self.cashBalanceInputs = @[ @0, @0, @0, @0 ];
	
	self.console.message = ATMControllerMessageEnterCashBalance;
	self.console.inputOptions = @[ @"10,000", @"1,000", @"100", @"10", @"Done" ];
	
	[self.console addObserver:self keyPath:@"lastInputReceived" options:0 block:^(MAKVONotification *notification) {
		
		[self didReceiveCashBalanceInput];
		
	}];
	
	self.cashBalance = 0;
}

-(void)didReceiveCashBalanceInput {

	if (self.console.lastInputReceived < self.cashBalanceInputs.count) {
		
		// Digit selected
		
		NSNumber *input = self.cashBalanceInputs[self.console.lastInputReceived];
		
		input = [NSNumber numberWithInteger: ([input integerValue] + 1) % 10];
		
		NSMutableArray *newCashBalanceInputs = [NSMutableArray arrayWithCapacity:self.cashBalanceInputs.count];
		
		[self.cashBalanceInputs enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *stop) {
			
			if (idx == self.console.lastInputReceived) {
				[newCashBalanceInputs addObject:input];
			} else {
				[newCashBalanceInputs addObject:number];
			}
		}];
		
		self.cashBalanceInputs = [newCashBalanceInputs copy];
		
		NSString *inputsAsString = [self.cashBalanceInputs componentsJoinedByString:@""];
		
		self.console.message = [NSString stringWithFormat:@"%@\n%@0", ATMControllerMessageEnterCashBalance, inputsAsString];

	} else {
		
		// Done selected
		
		self.cashBalance = [[self.cashBalanceInputs componentsJoinedByString:@""] integerValue] * 10;
		
		if (self.cashBalance > 0) {

			[self endCashBalanceInput];
			
			[self prepareForInsertCard];
			
		} else {
			
			self.console.message = ATMControllerMessageInvalidInput;
			
		}
	}
	
}

-(void)endCashBalanceInput {

	[self.console removeObserver:self keyPath:@"lastInputReceived"];
	
	self.console.inputOptions = nil;

}

-(void)prepareForInsertCard {
	
	self.console.message = ATMControllerMessageInsertCard;
	
}

@end
