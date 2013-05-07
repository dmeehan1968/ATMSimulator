#import "Kiwi.h"
#import "ATMBindingManager.h"

@interface ObjectA : NSObject

@property (strong, nonatomic) NSString *aStringValue;
@property (assign, nonatomic) BOOL boolValue;

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
	
	it(@"should define a keypath macro so that keypaths are objects and refactoring produces compile time errors", ^{
		
		ATMKeypath *keypath = keypath(objectA.aStringValue);

		[[keypath.stringValue should] equal: @"aStringValue"];
	});

	
	it(@"should allow a binding to be made between two objects", ^{
		
		[sut bindObserver: objectA
				  keypath: keypath(objectA.aStringValue)
				toSubject: objectB
				  keypath: keypath(objectB.bStringValue)];
		
	});

	it(@"should create a one-way binding, setting objectB.bStringValue should update objectA.aStringValue", ^{
		
		NSString *expectedResult = @"New Value";
		objectA.aStringValue = @"Original Value";
		
		[sut bindObserver: objectA
				  keypath: keypath(objectA.aStringValue)
				toSubject: objectB
				  keypath: keypath(objectB.bStringValue)];

		[sut enable];
		
		objectB.bStringValue = expectedResult;
		
		[[objectA.aStringValue should] equal:expectedResult];
		
	});
	
	it(@"should create a two-way binding", ^{
		
		NSString *firstChange = @"ObjectB First Change";
		NSString *secondChange = @"ObjectA Second Change";
		
		objectA.aStringValue = @"ObjectA Original Value";
		
		[sut bindBothObserver: objectA
					  keypath: keypath(objectA.aStringValue)
					toSubject: objectB
					  keypath: keypath(objectB.bStringValue)];
		
		[sut enable];
		
		objectB.bStringValue = firstChange;
		
		objectA.aStringValue = secondChange;
		
		[[objectB.bStringValue should] equal:secondChange];		
		
	});
	
	it(@"should ignore changes when bindings disabled", ^{
		
		NSString *newValue = @"New Value";
		NSString *originalValue = @"Original Value";
		objectA.aStringValue = originalValue;
		
		[sut bindObserver: objectA
				  keypath: keypath(objectA.aStringValue)
				toSubject: objectB
				  keypath: keypath(objectB.bStringValue)];
		
		[sut disable]; // NB: Disabled by default, but for test clarity
		
		objectB.bStringValue = newValue;
		
		[[objectA.aStringValue should] equal:originalValue];
		
	});
	
	it(@"should not enable new bindings if binding manager already enabled", ^{
		
		NSString *originalValue = @"Original Value";
		objectA.aStringValue = originalValue;
		
		[sut enable];
		
		[sut bindObserver:objectA
				  keypath:keypath(objectA.aStringValue)
				toSubject:objectB
				  keypath:keypath(objectB.bStringValue)];
		
		objectB.bStringValue = @"Not Relevant";
		
		[[objectA.aStringValue should] equal:originalValue];
		
	});
	
	it(@"should provide translation block to convert between types for one-way bindings", ^{
	
		[sut bindObserver:objectB
				  keypath:keypath(objectB.bStringValue)
				toSubject:objectA
				  keypath:keypath(objectA.boolValue)
			   translator:^id(id newValue) {
				   return [newValue boolValue] ? @"On" : @"Off";
			   }];

		[sut enable];
		
		objectA.boolValue = YES;
		
		[[objectB.bStringValue should] equal:@"On"];
		
	});

    it(@"should provide translation block to convert between type for two-way bindings", ^{
       
        [sut bindBothObserver:objectA
                      keypath:keypath(objectA.boolValue)
                    toSubject:objectB
                      keypath:keypath(objectB.bStringValue)
                   translator:^id(BOOL forObserver, id newValue) {
                       
                       if (forObserver) {
                           return [newValue boolValue] ? @"On" : @"Off";
                       }
                       return [NSNumber numberWithBool:[newValue isEqual:@"On"] ? YES : NO];
                       
                   }];
        
    });
    
});

SPEC_END