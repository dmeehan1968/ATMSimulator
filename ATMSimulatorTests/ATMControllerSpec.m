#import "Kiwi.h"
#import "ATMController.h"

SPEC_BEGIN(ATMControllerSpec)

describe(@"ATM Controller", ^{
	
    __block ATMController *sut;
    
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
		
	});

	
    
});

SPEC_END