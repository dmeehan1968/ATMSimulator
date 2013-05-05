#import "Kiwi.h"
#import "ATMConsole.h"

SPEC_BEGIN(ATMConsoleSpec)

describe(@"ATMConsole", ^{
	
    __block ATMConsole *sut;
	__block id delegate;
	
    beforeEach(^{
		
        sut = [[ATMConsole alloc] init];
		delegate = [KWMock mockForProtocol:@protocol(ATMConsoleDelegate)];
		
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

	it(@"can assign a delegate that conforms to ATMConsoleDelegate", ^{
		
		sut.delegate = delegate;
		
		[[(id)sut.delegate should] equal: delegate];
		
	});

	it(@"should notify delegate when message changes", ^{

		NSString *expectedResult = @"Test Message";
		
		sut.delegate = delegate;
		
		[[delegate should] receive:@selector(console:didChangeMessage:) withArguments:sut,expectedResult];
		
		sut.message = expectedResult;
		
	});

	

    
});

SPEC_END