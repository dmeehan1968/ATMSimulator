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
    
});

SPEC_END