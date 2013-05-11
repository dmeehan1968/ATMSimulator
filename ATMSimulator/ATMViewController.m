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
	[self sortButtons];
	[self hideButtons];
	
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

#pragma mark - Buttons

-(void) sortButtons {

	self.buttonCollection = [self.buttonCollection sortedArrayUsingComparator:^NSComparisonResult(UIButton *button1, UIButton *button2) {
		
		if (button1.tag == button2.tag) {
			return NSOrderedSame;
		}
		
		return button1.tag < button2.tag ? NSOrderedAscending : NSOrderedDescending;
	}];
	
}

-(void)hideButtons {
	
	[self.buttonCollection enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
		
		button.hidden = YES;
	}];
	
}

-(void)configureButtonsToMatchInputOptions {
	
	[self.buttonCollection enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
		
		if (idx < self.console.inputOptions.count) {
			
			[button setTitle: self.console.inputOptions[idx] forState:UIControlStateNormal];
			button.hidden = NO;
			[button touchUpInside:^(UIEvent *event) {
				
				[self.console didSelectInputOption: idx];
				
			}];
			
		} else {
			
			button.hidden = YES;
			[button removeBlocksForControlEvents:UIControlEventTouchUpInside];
		}
		
	}];
	
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

	[self.console addObservationKeyPath:@"inputOptions" options:0 block:^(MAKVONotification *notification) {
	
		[weakSelf configureButtonsToMatchInputOptions];

	}];
	
	self.console.message = self.console.message;
	
}

@end



