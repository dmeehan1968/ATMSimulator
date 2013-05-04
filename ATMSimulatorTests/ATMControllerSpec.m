#import "Kiwi.h"
#import "ATMController.h"

SPEC_BEGIN(ATMControllerSpec)

describe(@"ATM Controller", ^{
	
    __block ATMController *sut;
    __block id console;
	
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
		
		it(@"can have a console assigned", ^{
			
			console = [KWMock mockForProtocol:@protocol(ATMConsole)];
			
			sut.console = console;
			
			[[(id)sut.console should] equal:console];
			
		});

		
	});

	
    
});

SPEC_END