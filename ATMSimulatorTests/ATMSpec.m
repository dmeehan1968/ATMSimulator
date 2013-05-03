#import "kiwi.h"
#import "ATM.h"

SPEC_BEGIN(ATMSpec)

describe(@"ATM", ^{
    
    __block ATM *atm;
    __block id console;
    
    beforeAll(^{
        
        console = [KWMock mockForProtocol:@protocol(ATMConsole)];
        [[console should] receive:@selector(setMessage:) withArguments:@"Not Available"];
        atm = [ATM new];
        atm.console = console;
    });
    
    afterAll(^{
        
        atm = nil;
        
    });
    
    it(@"should exist", ^{
        
        [atm shouldNotBeNil];
        
    });
    
    it(@"should show 'not available' on console when not in service", ^{
       
        [[console should] receive:@selector(message) andReturn: @"Not Available"];
        
        [[[atm.console message] should] equal: @"Not Available"];
        
    });

    context(@"Bring into service", ^{
        
        it(@"should show 'enter initial cash balance'", ^{
            
            [[console should] receive:@selector(setMessage:) withArguments:@"Enter Initial Cash Balance"];
            
			[atm setInService: YES];
			
        });
        
		context(@"after receiving cash balance", ^{
			
			it(@"should show 'please insert card' after receiving cash balance", ^{
				
				[[console should] receive:@selector(setMessage:) withArguments:@"Please Insert Card"];
				
				[atm setCashBalance: 1000.00];
				
			});
            
		});
        
    });
    
	context(@"Taking out of service", ^{
       
        it(@"should show 'not available'", ^{
           
            [[console should] receive:@selector(setMessage:) withArguments:@"Not Available"];
            
            [atm setInService: NO];
        });
        
    });
	
});

SPEC_END