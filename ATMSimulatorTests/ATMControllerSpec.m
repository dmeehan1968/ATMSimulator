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
			
			[sut.console shouldBeNil];
			
		});
		
		it(@"sets 'not available' when console assigned", ^{
			
			console = [KWMock mockForProtocol:@protocol(ATMConsole)];
			
			[[console should] receive:@selector(setMessage:) withArguments:ATMControllerMessageNotAvailable];
			
			sut.console = console;
			
		});

	});

	context(@"Operator Switch", ^{
		
		it(@"should not have a keyswitch on startup", ^{
			
			[sut.operatorSwitch shouldBeNil];
			
		});
		
        it(@"should send initial message to console when operator switch assigned", ^{
        
            operatorSwitch = [KWMock mockForProtocol:@protocol(ATMOperatorSwitch)];

            sut.operatorSwitch = operatorSwitch;
			
			[[sut.operatorSwitch should] equal:operatorSwitch];
            
        });
        		
	});

});

SPEC_END