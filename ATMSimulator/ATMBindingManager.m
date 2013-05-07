//
//  ATMBindingManager.m
//  ATMSimulator
//
//  Created by Dave Meehan on 05/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import "ATMBindingManager.h"

@implementation ATMKeypath

+(id)keypathWithString:(NSString *)stringValue expression:(id)var {
	
	id keypath = [[self alloc] init];
	
	NSArray *array = [stringValue componentsSeparatedByString:@"."];
	
	array = [array subarrayWithRange:NSMakeRange(1, array.count - 1)];
	
	[keypath setStringValue: [array componentsJoinedByString:@"."]];
	
	return keypath;
}

@end


@interface ATMBinding : NSObject

@property (weak, readonly) id observer;
@property (strong, nonatomic, readonly) ATMKeypath *observerKeypath;
@property (weak, readonly) id subject;
@property (strong, nonatomic, readonly) ATMKeypath *subjectKeypath;
@property (assign, nonatomic, getter = isEnabled, readonly) BOOL enable;

-(id)initWithObserver: (id) observer keypath: (ATMKeypath *) observerKeypath forSubject: (id) subject keypath: (ATMKeypath *) subjectKeypath;

-(void)enable;
-(void)disable;

@end

@implementation ATMBinding

-(id)initWithObserver:(id)observer keypath:(ATMKeypath *)observerKeypath forSubject:(id)subject keypath:(ATMKeypath *)subjectKeypath {

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
	
	[self.subject addObserver:self forKeyPath:self.subjectKeypath.stringValue options:NSKeyValueObservingOptionNew context:nil];
}

-(void)disable {

	if (self.isEnabled == NO) {
		return;
	}
	
	[self.subject removeObserver:self forKeyPath:self.subjectKeypath.stringValue context:nil];
	
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	
	id newValue = [change valueForKey: NSKeyValueChangeNewKey];
	
	id oldValue = [self.observer valueForKey:self.observerKeypath.stringValue];
	
	if (oldValue != newValue) {
		[self.observer setValue:newValue forKey:self.observerKeypath.stringValue];
	}
	
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

-(void)bindObserver:(id)observer keypath:(ATMKeypath *)observerKeypath toSubject:(id)subject keypath:(ATMKeypath *)subjectKeypath {
	
	ATMBinding *binding = [[ATMBinding alloc] initWithObserver:observer keypath:observerKeypath forSubject:subject keypath:subjectKeypath];
	
	self.bindings = [self.bindings arrayByAddingObject:binding];
}

-(void)bindBothObserver:(id)observer keypath:(ATMKeypath *)observerKeypath toSubject:(id)subject keypath:(ATMKeypath *)subjectKeypath {

	[self bindObserver:observer keypath:observerKeypath toSubject:subject keypath:subjectKeypath];
	
	[self bindObserver:subject keypath:subjectKeypath toSubject:observer keypath:observerKeypath];
	
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
