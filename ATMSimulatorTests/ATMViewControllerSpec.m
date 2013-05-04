#import "Kiwi.h"
#import "ATMViewController.h"

SPEC_BEGIN(ATMViewControllerSpec)

describe(@"ATMViewController", ^{
	
    __block ATMViewController *sut;
    
    beforeEach(^{
		
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
		
        sut = [storyboard instantiateViewControllerWithIdentifier:@"ATMUserInterface"];
		
        [sut view];
    });
    
    afterEach(^{
        
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
			
			[[(id)sut.atmController.operatorSwitch should] equal: sut.operatorSwitch];
			
		});
		
		it(@"should have UISwitch outlet to represent the operator switch", ^{
			
			[sut.operatorSwitchUI shouldNotBeNil];
			
		});
		
		it(@"should have matching state for operator switch and UI switch", ^{
			
			[[theValue(sut.operatorSwitch.state) should] equal: theValue(sut.operatorSwitchUI.isOn)];
			
		});

		it(@"should have an IBAction for changes to UISwitch", ^{
			
			[[sut should] respondToSelector:@selector(didChangeValueForOperatorSwitchUI:)];
			
			[[[sut.operatorSwitchUI actionsForTarget:sut forControlEvent:UIControlEventValueChanged] should] contain:@"didChangeValueForOperatorSwitchUI:"];
			
		});
		
		it(@"should change state of operator switch to YES", ^{
			
			id mockSwitch = [KWMock mockForClass:[UISwitch class]];
			
			[[mockSwitch should] receive:@selector(isOn) andReturn:theValue(YES)];
			
			[[sut.operatorSwitch should] receive:@selector(setState:) withArguments:theValue(YES)];
			
			[sut didChangeValueForOperatorSwitchUI:mockSwitch];
		});
		
	});

	context(@"Console", ^{
		
		it(@"should have an instance of a console", ^{
			
			[sut.console shouldNotBeNil];
			
		});

		
	});

    
});

SPEC_END