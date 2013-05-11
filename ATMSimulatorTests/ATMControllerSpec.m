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
		
		it(@"should display 'not available' when operator switch moved to OFF", ^{
			
			[[console should] receive:@selector(setMessage:) withArguments:ATMControllerMessageNotAvailable];
			
			operatorSwitch.state = NO;
			
		});
        
	});
	
	context(@"Enter Cash Balance", ^{
		
		beforeAll(^{
			operatorSwitch.state = YES;
		});
		
		it(@"should assign input options to console", ^{
			
			[[console.inputOptions should] haveCountOf:5];
			[[console.inputOptions should] containObjects:@"10,000", @"1,000", @"100", @"10", @"Done", nil];
			
		});
		
		it(@"should have cash balance of 43210 with simulated input", ^{
			
			[console didSelectInputOption:0];	// 10,000
			[console didSelectInputOption:0];	// 10,000
			[console didSelectInputOption:0];	// 10,000
			[console didSelectInputOption:0];	// 10,000

			[console didSelectInputOption:1];	// 1,000
			[console didSelectInputOption:1];	// 1,000
			[console didSelectInputOption:1];	// 1,000

			[console didSelectInputOption:2];	// 100
			[console didSelectInputOption:2];	// 100

			[console didSelectInputOption:3];	// 10

			[console didSelectInputOption:4];	// Done
			
			[[theValue(sut.cashBalance) should] equal: theValue(43210)];
			
		});


		
		xit(@"should receive initial cash balance", ^{
			
			// TODO
			
		});

		
	});

});

SPEC_END