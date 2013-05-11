
#import "ATMConsole.h"

@implementation ATMConsole

@synthesize message = _message;
@synthesize inputOptions = _inputOptions;
@synthesize lastInputReceived = _lastInputReceived;

-(id)init {

	if (self = [super init]) {
		_message = @"";
		_inputOptions = @[];
		_lastInputReceived = NSNotFound;
	}
	
	return self;
	
}

-(void)didSelectInputOption:(NSInteger)index {
	
	NSParameterAssert(index < self.inputOptions.count);
	
	self.lastInputReceived = index;
	
}

@end
