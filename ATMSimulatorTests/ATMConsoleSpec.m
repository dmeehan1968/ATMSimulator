#import "Kiwi.h"
#import "ATMConsole.h"

SPEC_BEGIN(ATMConsoleSpec)

describe(@"ATMConsole", ^{
	
    __block ATMConsole *sut;
	__block id delegate;
	
    beforeEach(^{
		
		delegate = [KWMock mockForProtocol:@protocol(ATMConsoleDelegate)];
        sut = [[ATMConsole alloc] initWithDelegate: delegate];
		
    });
    
    afterEach(^{
        
        sut = nil;
    });
    
    it(@"should exist", ^{
        
        [sut shouldNotBeNil];
        
    });
	
	it(@"should not have a setDelegate: message", ^{
		
		[[sut shouldNot] respondToSelector:@selector(setDelegate:)];
		
	});

	
	it(@"should be able to assign a message", ^{
		
		NSString *expectedResult = @"This is a test";
		sut.message = expectedResult;
		
		[[sut.message should] equal: expectedResult];
	});
	
	it(@"should notify delegate when message changes", ^{

		NSString *expectedResult = @"Test Message";
		
		[[delegate should] receive:@selector(console:didChangeMessage:) withArguments:sut,expectedResult];
		
		sut.message = expectedResult;
		
	});

	

    
});

SPEC_END