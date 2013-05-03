#import "kiwi.h"
#import "ATM.h"

SPEC_BEGIN(ATMSpec)

describe(@"ATM", ^{
    
    __block ATM *atm;
    __block id console;
    
    beforeEach(^{
        
        console = [KWMock mockForProtocol:@protocol(ATMConsole)];
        [[console should] receive:@selector(setMessage:) withArguments:@"Not Available"];
        atm = [ATM new];
        atm.console = console;
    });
    
    afterEach(^{
        
        atm = nil;
        
    });
    
    it(@"should exist", ^{
        
        [atm shouldNotBeNil];
        
    });
    
    it(@"should show 'not available' on console when powered off", ^{
       
        [[console should] receive:@selector(message) andReturn: @"Not Available"];
        
        [[[atm.console message] should] equal: @"Not Available"];
        
    });
    
});

SPEC_END