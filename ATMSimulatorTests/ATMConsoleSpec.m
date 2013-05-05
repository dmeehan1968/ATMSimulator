#import "Kiwi.h"
#import "ATMConsole.h"

SPEC_BEGIN(ATMConsoleSpec)

describe(@"ATMConsole", ^{
	
    __block ATMConsole *sut;
    
    beforeEach(^{
		
        sut = [[ATMConsole alloc] init];
        
    });
    
    afterEach(^{
        
        sut = nil;
    });
    
    it(@"should exist", ^{
        
        [sut shouldNotBeNil];
        
    });
	
	it(@"should be able to assign a message", ^{
		
		NSString *expectedResult = @"This is a test";
		sut.message = expectedResult;
		
		[[sut.message should] equal: expectedResult];
	});
	
	it(@"should have a delegate property", ^{
		
		sut.delegate = nil;
		
	});


    
});

SPEC_END