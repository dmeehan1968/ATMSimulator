#import "Kiwi.h"
#import "ATMBindingManager.h"

@interface ObjectA : NSObject

@property (strong, nonatomic) NSString *aStringValue;

@end

@implementation ObjectA

@end

@interface ObjectB : NSObject

@property (strong, nonatomic) NSString *bStringValue;

@end

@implementation ObjectB

@end

SPEC_BEGIN(ATMBindingManagerSpec)

describe(@"ATMBindingManager", ^{
	
    __block ATMBindingManager *sut;
	__block ObjectA *objectA;
	__block ObjectB *objectB;
    
    beforeEach(^{
		
        sut = [[ATMBindingManager alloc] init];
		objectA = [ObjectA new];
		objectB = [ObjectB new];
        
    });
    
    afterEach(^{
        
        sut = nil;
    });
    
    it(@"should exist", ^{
        
        [sut shouldNotBeNil];
        
    });
	
	it(@"should allow a binding to be made between two objects", ^{
		
		[sut bind: objectA keypath: @"aStringValue" subject: objectB keypath: @"bStringValue"];
		
	});

	xit(@"should create a one-way binding, setting objectB.bStringValue should update objectA.aStringValue", ^{
		
		NSString *expectedResult = @"Test Value";
		
		[sut bind: objectA keypath: @"aStringValue" subject: objectB keypath: @"bStringValue"];
		
		objectB.bStringValue = expectedResult;
		
		[[objectA.aStringValue should] equal:expectedResult];
		
	});

    
});

SPEC_END