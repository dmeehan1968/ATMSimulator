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
	
	it(@"should allow state to be assigned", ^{
		
        sut.state = YES;
		
		[[theValue(sut.state) should] beYes];
        
    });

    
});

SPEC_END