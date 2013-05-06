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
		
		[sut bindObserver: objectA keypath: @"aStringValue" toSubject: objectB keypath: @"bStringValue"];
		
	});

	it(@"should create a one-way binding, setting objectB.bStringValue should update objectA.aStringValue", ^{
		
		NSString *expectedResult = @"New Value";
		objectA.aStringValue = @"Original Value";
		
		[sut bindObserver: objectA keypath: @"aStringValue" toSubject: objectB keypath: @"bStringValue"];

		[sut enable];
		
		objectB.bStringValue = expectedResult;
		
		[[objectA.aStringValue should] equal:expectedResult];
		
	});

    
});

SPEC_END