//
//  ATMBindingManager.m
//  ATMSimulator
//
//  Created by Dave Meehan on 05/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import "ATMBindingManager.h"

@interface ATMBinding : NSObject

@property (weak, readonly) id observer;
@property (strong, nonatomic, readonly) NSString *observerKeypath;
@property (weak, readonly) id subject;
@property (strong, nonatomic, readonly) NSString *subjectKeypath;
@property (assign, nonatomic, getter = isEnabled, readonly) BOOL enable;

-(id)initWithObserver: (id) observer keypath: (NSString *) observerKeypath forSubject: (id) subject keypath: (NSString *) subjectKeypath;

-(void)enable;
-(void)disable;

@end

@implementation ATMBinding

-(id)initWithObserver:(id)observer keypath:(NSString *)observerKeypath forSubject:(id)subject keypath:(NSString *)subjectKeypath {

	if (self = [super init]) {
		
		_observer = observer;
		_observerKeypath = observerKeypath;
		_subject = subject;
		_subjectKeypath = subjectKeypath;
		_enable = NO;
		
	}
	
	return self;
}

-(void)enable {

	if (self.isEnabled) {
		return;
	}
	
	[self.subject addObserver:self forKeyPath:self.subjectKeypath options:NSKeyValueObservingOptionNew context:nil];
}

-(void)disable {

	if (self.isEnabled == NO) {
		return;
	}
	
	[self.subject removeObserver:self forKeyPath:self.subjectKeypath context:nil];
	
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	
	id newValue = [change valueForKey: NSKeyValueChangeNewKey];
	
	NSLog(@"New Value: %@", newValue);
	
	[self.observer setValue:newValue forKey:self.observerKeypath];
	
}

@end

@interface ATMBindingManager ()

@property (strong, nonatomic) NSArray *bindings;

@end

@implementation ATMBindingManager

-(id)init {
	if (self = [super init]) {
		_bindings = @[];
	}
	return self;
}

-(void)bindObserver:(id)observer keypath:(NSString *)observerKeypath toSubject:(id)subject keypath:(NSString *)subjectKeypath {
	
	ATMBinding *binding = [[ATMBinding alloc] initWithObserver:observer keypath:observerKeypath forSubject:subject keypath:subjectKeypath];
	
	self.bindings = [self.bindings arrayByAddingObject:binding];
}

-(void)enable {
	
	[self.bindings enumerateObjectsUsingBlock:^(ATMBinding *binding, NSUInteger idx, BOOL *stop) {
		
		[binding enable];
		
	}];
}

-(void)disable {
	
	[self.bindings enumerateObjectsUsingBlock:^(ATMBinding *binding, NSUInteger idx, BOOL *stop) {
		
		[binding disable];
		
	}];
}

@end
