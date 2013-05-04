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
		
		it(@"can assign an operator switch", ^{
			
			operatorSwitch = [KWMock mockForProtocol:@protocol(ATMOperatorSwitch)];
			
			sut.operatorSwitch = operatorSwitch;
			
			[[(id)sut.operatorSwitch should] equal:operatorSwitch];
			
		});

		it(@"should assign atm controller as operator switch delegate", ^{
			
			[[(id)sut.operatorSwitch.delegate should] equal: sut];
			
		});

		
	});

	
    
});

SPEC_END