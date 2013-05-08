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
			
			[[console should] receive:@selector(setMessage:) withArguments:ATMControllerMessageNotAvailable];
			
			sut.console = console;
			
			[[(id)sut.console should] equal:console];
			
		});

	});

	context(@"Operator Switch", ^{
		
		it(@"should not have a keyswitch on startup", ^{
			
			[(id)sut.operatorSwitch shouldBeNil];
			
		});
		
        it(@"should send initial message to console when operator switch assigned", ^{
        
            operatorSwitch = [KWMock mockForProtocol:@protocol(ATMOperatorSwitch)];
            
            [[operatorSwitch should] receive:@selector(setState:)];
            [[operatorSwitch should] receive:@selector(state) andReturn:theValue(NO)];
            [[console should] receive:@selector(setMessage:) withArguments:ATMControllerMessageNotAvailable];
        
            sut.console = console;
            sut.operatorSwitch = operatorSwitch;
            
        });
        		
	});

});

SPEC_END