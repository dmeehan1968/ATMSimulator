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
    
    it(@"should show 'not available' on console when powered off", ^{
       
        [[console should] receive:@selector(message) andReturn: @"Not Available"];
        
        [[[atm.console message] should] equal: @"Not Available"];
        
    });

    context(@"Power on sequence", ^{
        
        it(@"should show 'enter initial cash balance' on console when powered on", ^{
            
            [[console should] receive:@selector(setMessage:) withArguments:@"Enter Initial Cash Balance"];
            
            [atm powerOn];
            
        });
        
        it(@"should show 'please insert card' after receiving cash balance", ^{
            
            [[console should] receive:@selector(setMessage:) withArguments:@"Please Insert Card"];
            
            [atm setCashBalance: 1000.00];
            
        });
        
    });
    
    context(@"Power off sequence", ^{
       
        it(@"should show 'not available' when powered off", ^{
           
            [[console should] receive:@selector(setMessage:) withArguments:@"Not Available"];
            
            [sut powerOff];
        });
        
    });
    
});

SPEC_END