#import "Kiwi.h"
#import "ATMController.h"

SPEC_BEGIN(ATMControllerSpec)

describe(@"ATM Controller", ^{
	
    __block ATMController *sut;
    __block id console;
	__block id operatorSwitch;
	
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
			
			[(id)sut.console shouldBeNil];
			
		});
		
		it(@"sets 'not available' on startup", ^{
			
			console = [KWMock mockForProtocol:@protocol(ATMConsole)];
			
			[[console should] receive:@selector(setMessage:) withArguments:@"Not Available"];
			
			sut.console = console;
			
			[[(id)sut.console should] equal:console];
			
		});

	});

	context(@"Operator Switch", ^{
		
		it(@"should not have a keyswitch on startup", ^{
			
			[(id)sut.operatorSwitch shouldBeNil];
			
		});
		
		it(@"should assign atm controller as operator switch delegate", ^{
			
			operatorSwitch = [KWMock mockForProtocol:@protocol(ATMOperatorSwitch)];
			
			[[operatorSwitch should] receive:@selector(setDelegate:) withArguments:sut];
			
			sut.operatorSwitch = operatorSwitch;
			
			[[(id)sut.operatorSwitch should] equal:operatorSwitch];
			
		});

		it(@"atm should respond to switch notification", ^{
			
			[[sut should] respondToSelector:@selector(operatorSwitch:didChangeToState:)];
			
		});
		
	});

	context(@"Bringing into Service", ^{
		
		it(@"should ask for initial balance when operator switch turned on", ^{
			
			[[(id)sut.console should] receive:@selector(setMessage:) withArguments:@"Please Enter Initial Cash Balance"];
			
			[sut operatorSwitch: operatorSwitch didChangeToState:YES];
			
		});

		xit(@"accept input of cash balance", ^{
			
			// TODO
			
		});

	});

    
});

SPEC_END