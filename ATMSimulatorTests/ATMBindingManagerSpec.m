#import "Kiwi.h"
#import "ATMBindingManager.h"

SPEC_BEGIN(ATMBindingManagerSpec)

describe(@"ATMBindingManager", ^{
	
    __block ATMBindingManager *sut;
    
    beforeEach(^{
		
        sut = [[ATMBindingManager alloc] init];
        
    });
    
    afterEach(^{
        
        sut = nil;
    });
    
    it(@"should exist", ^{
        
        [sut shouldNotBeNil];
        
    });
    
});

SPEC_END