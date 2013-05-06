//
//  ATMBindingManager.m
//  ATMSimulator
//
//  Created by Dave Meehan on 05/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import "ATMBindingManager.h"

@interface ATMBinding : NSObject

@property (weak) id observer;
@property (strong, nonatomic) NSString *observerKeypath;
@property (weak) id subject;
@property (strong, nonatomic) NSString *subjectKeypath;

-(void)enable;
-(void)disable;

@end

@implementation ATMBinding

-(void)enable {

	[self.subject addObserver:self forKeyPath:self.subjectKeypath options:NSKeyValueObservingOptionNew context:nil];
}

-(void)disable {

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

-(void)bind:(id)observer keypath:(NSString *)observerKeypath subject:(id)subject keypath:(NSString *)subjectKeypath {
	
	ATMBinding *binding = [ATMBinding new];
	
	binding.observer = observer;
	binding.observerKeypath = observerKeypath;
	binding.subject = subject;
	binding.subjectKeypath = subjectKeypath;

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
