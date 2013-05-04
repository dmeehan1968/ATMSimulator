#import "Kiwi.h"
#import "ATMOperatorSwitch.h"

SPEC_BEGIN(ATMOperatorSwitchSpec)

describe(@"ATMOperatorSwitch", ^{
	
    __block ATMOperatorSwitch *sut;
    
    beforeEach(^{
		
        sut = [[ATMOperatorSwitch alloc] init];
        
    });
    
    afterEach(^{
        
        sut = nil;
    });
    
    it(@"should exist", ^{
        
        [sut shouldNotBeNil];
        
    });
	
	it(@"should have a state (on/off) which should be off by default", ^{
		
		[[theValue(sut.state) should] beNo];
		
	});

	it(@"should notify delegate when state changes", ^{
		
		id delegate = [KWMock mockForProtocol:@protocol(ATMOperatorSwitchDelegate)];
		
		[[delegate should] receive:@selector(operatorSwitch:didChangeToState:) withArguments:sut, theValue(YES)];
		
		sut.delegate = delegate;
		
		sut.state = YES;
		
	});

    
});

SPEC_END