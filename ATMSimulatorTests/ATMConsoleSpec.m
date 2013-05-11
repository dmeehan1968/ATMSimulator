#import "Kiwi.h"
#import "ATMConsole.h"

SPEC_BEGIN(ATMConsoleSpec)

describe(@"ATMConsole", ^{
	
    __block ATMConsole *sut;
	
    beforeEach(^{
		
        sut = [ATMConsole new];
		
    });
    
    afterEach(^{
        
        sut = nil;
    });
    
    it(@"should exist", ^{
        
        [sut shouldNotBeNil];
        
    });

	it(@"should allow message to be assigned", ^{
		
        sut.message = @"Test Message";
        
    });
	
	it(@"should have a collection for input options", ^{
		
        [sut.inputOptions shouldNotBeNil];
        
    });

	it(@"should have no input options by default", ^{
		
        [[sut.inputOptions should] haveCountOf:0];
        
    });


});

SPEC_END