#import "Kiwi.h"
#import "ATMController.h"
#import "ATMConsole.h"
#import "ATMOperatorSwitch.h"

SPEC_BEGIN(ATMControllerSpec)

describe(@"ATM Controller", ^{
	
    __block ATMController *sut;
    __block ATMConsole *console;
	__block ATMOperatorSwitch *operatorSwitch;
	
    beforeEach(^{
		
        sut = [[ATMController alloc] init];
		console = [ATMConsole new];
		operatorSwitch = [ATMOperatorSwitch new];
        
    });
    
    afterEach(^{
        
        sut = nil;
		console = nil;
		operatorSwitch = nil;
		
    });
    
    it(@"should exist", ^{
        
        [sut shouldNotBeNil];
        
    });
	
	context(@"ATM State Transitions", ^{

		it(@"should not have a console at startup", ^{
			
			[sut.console shouldBeNil];
			
		});
		
		context(@"Assigning Console", ^{

			beforeEach(^{
				
				sut.console = console;
				
			});
			

			it(@"should allow a console to be assigned", ^{
			
				[[sut.console should] equal: console];
			
			});
			
			it(@"should assign 'not available' console message", ^{
				
				[[sut.console.message should] equal: ATMControllerMessageNotAvailable];
				
			});

		});

		it(@"should not have an operator switch on startup", ^{
			
			[sut.operatorSwitch shouldBeNil];
			
		});
		
		context(@"Assigning Operator Switch", ^{

			beforeEach(^{
				
				sut.operatorSwitch = operatorSwitch;
				
			});
		
			it(@"should be able to assign operator switch", ^{
				
				[[sut.operatorSwitch should] equal:operatorSwitch];
				
			});
			
		});
		
		context(@"Switching Operator Switch ON", ^{

			beforeEach(^{
				
				sut.console = console;
				sut.operatorSwitch = operatorSwitch;				
				sut.operatorSwitch.state = YES;
				
			});
			

			it(@"should set message to request cash balance", ^{
				
				[[console.message should] equal: ATMControllerMessageEnterCashBalance];
				
			});
			
			it(@"should have 5 input options for cash balance entry", ^{
				
				[[console.inputOptions should] haveCountOf:5];
				
			});
			
			it(@"should have input options for each power of 10 cash amount, plus done button", ^{
				
				[[console.inputOptions should] containObjects:@"10,000", @"1,000", @"100", @"10", @"Done", nil];
				
			});

			context(@"Switching Operator Switch OFF", ^{
				
				beforeEach(^{
					
					operatorSwitch.state = NO;
					
				});
				
				it(@"should change console message to 'not available'", ^{
					
					[[console.message should] equal:ATMControllerMessageNotAvailable];
					
				});

				it(@"should remove input options", ^{
					
					[[console.inputOptions should] haveCountOf:0];
					
				});

			});
			
			context(@"Entry of Cash Balance", ^{
				
				it(@"should allow operator switch to move to OFF", ^{
					
					operatorSwitch.state = NO;
					
					[[console.message should] equal:ATMControllerMessageNotAvailable];
					
				});
				
				it(@"should have zero cash balance before input", ^{
					
					[[theValue(sut.cashBalance) should] equal: theValue(0)];
					
				});

				it(@"should not allow done to be selected with zero balance", ^{
					
					[console didSelectInputOption:4];	// Done
					
					[[console.message should] equal:ATMControllerMessageEnterCashBalance];
					
				});

				it(@"should allow input 0 to be selected and message should include 10000", ^{
					
					[console didSelectInputOption:0];	// 10,000
					
					[[console.message should] containString:@"10000"];
					
				});

				it(@"should allow input 0 twice and message should include 20000", ^{
					
					[console didSelectInputOption:0];
					[console didSelectInputOption:0];
					
					[[console.message should] containString:@"20000"];
					
				});
				
				it(@"should allow input 1 twice and message should include 2000", ^{
					
					[console didSelectInputOption:1];
					[console didSelectInputOption:1];
					
					[[console.message should] containString:@"2000"];
					
				});
				
				it(@"should allow input 2 twice and message should include 200", ^{
					
					[console didSelectInputOption:2];
					[console didSelectInputOption:2];
					
					[[console.message should] containString:@"200"];
					
				});
				
				it(@"should allow input 3 twice and message should include 20", ^{
					
					[console didSelectInputOption:3];
					[console didSelectInputOption:3];
					
					[[console.message should] containString:@"20"];
					
				});
				
				
				xit(@"should have cash balance of 43210 with simulated input", ^{
					
					[console didSelectInputOption:0];	// 10,000
					[console didSelectInputOption:0];	// 10,000
					[console didSelectInputOption:0];	// 10,000
					[console didSelectInputOption:0];	// 10,000
					
					[console didSelectInputOption:1];	// 1,000
					[console didSelectInputOption:1];	// 1,000
					[console didSelectInputOption:1];	// 1,000
					
					[console didSelectInputOption:2];	// 100
					[console didSelectInputOption:2];	// 100
					
					[console didSelectInputOption:3];	// 10
					
					[console didSelectInputOption:4];	// Done
					
					[[theValue(sut.cashBalance) should] equal: theValue(43210)];
					
				});

				
			});
			

			
		});
		

	
	
	
	
	});

});

SPEC_END