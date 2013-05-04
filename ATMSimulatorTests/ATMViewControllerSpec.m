#import "Kiwi.h"
#import "ATMViewController.h"

SPEC_BEGIN(ATMViewControllerSpec)

describe(@"ATMViewController", ^{
	
    __block ATMViewController *sut;
    
    beforeEach(^{
		
        sut = [[ATMViewController alloc] init];
        [sut view];
    });
    
    afterEach(^{
        
        sut = nil;
    });
    
    it(@"should exist", ^{
        
        [sut shouldNotBeNil];
        
    });
	
	it(@"should have an instance of an ATM controller", ^{
		
		[sut.atmController shouldNotBeNil];
		
	});

    
});

SPEC_END