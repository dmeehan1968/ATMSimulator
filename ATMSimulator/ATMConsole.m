
#import "ATMConsole.h"

@implementation ATMConsole

@synthesize message = _message;
@synthesize inputOptions = _inputOptions;

-(id)init {

	if (self = [super init]) {
		_message = @"";
		_inputOptions = @[];
	}
	
	return self;
	
}

@end
