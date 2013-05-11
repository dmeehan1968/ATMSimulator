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
	
	it(@"should have last input received set to not found be default", ^{
		
        [[theValue(sut.lastInputReceived) should] equal:theValue(NSNotFound)];
        
    });

	it(@"should raise exception if invalid input option selected", ^{
		
        sut.inputOptions = @[];
		
		[[theBlock(^{
			
			[sut didSelectInputOption:0];
		}) should] raiseWithName:@"NSInternalInconsistencyException"];
        
    });



});

SPEC_END