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

	context(@"operator switch", ^{
		
		it(@"should have an instance of an operator switch", ^{
			
			[sut.operatorSwitch shouldNotBeNil];
			
		});
		
		it(@"should have operator switch assigned to ATM controller", ^{
			
			[[(id)sut.atmController.operatorSwitch should] equal: sut.operatorSwitch];
			
		});
		
	});

    
});

SPEC_END