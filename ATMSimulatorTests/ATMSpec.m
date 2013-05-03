#import "kiwi.h"
#import "ATM.h"

SPEC_BEGIN(ATMSpec)

describe(@"ATM", ^{
    
    __block ATM *sut;
    
    beforeEach(^{
        
        sut = [ATM new];
        
    });
    
    afterEach(^{
        
        sut = nil;
        
    });
    
    it(@"should exist", ^{
        
        [sut shouldNotBeNil];
        
    });
    
    
});

SPEC_END