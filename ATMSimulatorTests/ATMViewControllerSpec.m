#import "Kiwi.h"
#import "ATMViewController.h"

SPEC_BEGIN(ATMViewControllerSpec)

describe(@"ATMViewController", ^{
	
    __block ATMViewController *sut;
    
    beforeEach(^{
		
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
		
        sut = [storyboard instantiateViewControllerWithIdentifier:@"ATMUserInterface"];
		
        [sut view];
		
		[sut viewDidAppear:NO];
    });
    
    afterEach(^{
        
		[sut viewDidDisappear:NO];
        sut = nil;
    });
    
    it(@"should exist", ^{
        
        [sut shouldNotBeNil];
        
    });
	
	it(@"should have an instance of an ATM controller", ^{
		
		[sut.atmController shouldNotBeNil];
		
	});

	context(@"operator switch", ^{
		
		it(@"should have an instance of an operator switch", ^{
			
			[sut.operatorSwitch shouldNotBeNil];
			
		});
		
		it(@"should have operator switch assigned to ATM controller", ^{
			
			[[sut.atmController.operatorSwitch should] equal: sut.operatorSwitch];
			
		});
		
		it(@"should have UISwitch outlet to represent the operator switch", ^{
			
			[sut.operatorSwitchUI shouldNotBeNil];
			
		});
		
		it(@"should have matching state for operator switch and UI switch", ^{
			
			[[theValue(sut.operatorSwitch.state) should] equal: theValue(sut.operatorSwitchUI.isOn)];
			
		});
		
		it(@"should change models operator switch state when UI switch changes value", ^{
			
			// invert current switch position
			[sut.operatorSwitchUI setOn:!sut.operatorSwitchUI.isOn animated:NO];
			// need to send control event as state change doesn't
			[sut.operatorSwitchUI sendActionsForControlEvents:UIControlEventValueChanged];
			// model state should now equal UI state
			[[theValue(sut.operatorSwitch.state) should] equal: theValue(sut.operatorSwitchUI.isOn)];
			
		});
		
		it(@"should change UI switch state when model state updated", ^{
			
			sut.operatorSwitch.state = !sut.operatorSwitch.state;
			
			[[theValue(sut.operatorSwitchUI.isOn) should] equal:theValue(sut.operatorSwitch.state)];
			
		});

		
	});

	context(@"Console", ^{
		
		it(@"should have an instance of a console", ^{
			
			[sut.console shouldNotBeNil];
			
		});

		it(@"should have console assigned to atm controller", ^{
			
			[[sut.atmController.console should] equal:sut.console];
			
		});
		
		it(@"should have an outlet to represent the message", ^{
			
			[sut.messageUI shouldNotBeNil];
			
		});
		
		it(@"should update message UI when console message changes", ^{
			
			NSString *expectedResult = @"Test Message";
			
			sut.console.message = expectedResult;
			
			[[sut.messageUI.text should] equal:expectedResult];
			
		});

		it(@"should have initial message in UI that matches console message", ^{
			
			[[sut.messageUI.text should] equal:sut.console.message];
			
		});
		
		it(@"should have a button collection with 8 buttons", ^{
			
			[[sut.buttonCollection should] haveCountOf:8];
				
		});
		
		it(@"should have buttons ordered by tag, but hidden by default", ^{
			
			[sut.buttonCollection enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
				
				[[theValue(button.tag) should] equal: theValue(idx)];
				
				[[theValue(button.hidden) should] beYes];
				
			}];
			
		});
		
	});
	
	context(@"Entering Cash Balance", ^{
		
		beforeEach(^{
			
			sut.operatorSwitch.state = YES;
			
		});
		
		it(@"button text should match console input options", ^{
						
			[sut.buttonCollection enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
				
				if (idx < sut.console.inputOptions.count) {
					
					[[button.currentTitle should] equal: sut.console.inputOptions[idx]];
					[[theValue(button.hidden) should] beNo];
					
				} else {
					
					[[theValue(button.hidden) should] beYes];
					
				}
				
			}];
			
		});
		
	});
    
});

SPEC_END