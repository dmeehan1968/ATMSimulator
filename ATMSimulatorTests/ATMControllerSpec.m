#import "Kiwi.h"
#import "ATMController.h"
#import "ATMConsole.h"
#import "ATMOperatorSwitch.h"

SPEC_BEGIN(ATMControllerSpec)

describe(@"ATM Controller", ^{
	
    __block ATMController *sut;
    __block ATMConsole *console;
	__block ATMOperatorSwitch *operatorSwitch;
	
    beforeAll(^{
		
        sut = [[ATMController alloc] init];
        
    });
    
    afterAll(^{
        
        sut = nil;
    });
    
    it(@"should exist", ^{
        
        [sut shouldNotBeNil];
        
    });
	
	context(@"Console", ^{
		
		it(@"should not have a console at startup", ^{
			
			[sut.console shouldBeNil];
			
		});
		
		it(@"sets 'not available' when console assigned", ^{
			
			console = [ATMConsole new];
			
			[[console should] receive:@selector(setMessage:) withArguments:ATMControllerMessageNotAvailable];
			
			sut.console = console;
			
		});

	});

	context(@"Operator Switch", ^{
		
		it(@"should not have a keyswitch on startup", ^{
			
			[sut.operatorSwitch shouldBeNil];
			
		});
		
        it(@"should be able to assign operator switch", ^{
        
            operatorSwitch = [ATMOperatorSwitch new];

            sut.operatorSwitch = operatorSwitch;
			
			[[sut.operatorSwitch should] equal:operatorSwitch];
            
        });
		
		it(@"should display 'enter cash balance' when operator switch moved to ON", ^{
			
			[[console should] receive:@selector(setMessage:) withArguments:ATMControllerMessageEnterCashBalance];
			
			operatorSwitch.state = YES;
			
		});

        
	});

});

SPEC_END