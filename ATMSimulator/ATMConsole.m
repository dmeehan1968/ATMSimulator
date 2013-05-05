
#import "ATMConsole.h"

@implementation ATMConsole

@synthesize message = _message;
@synthesize delegate = _delegate;

#pragma mark - Lifecycle

-(id)initWithDelegate:(id<ATMConsoleDelegate>)delegate {
	
	if (self = [super init]) {
		_delegate = delegate;
	}
	
	return self;
}

#pragma mark - Message

-(void)setMessage:(NSString *)message {
	
	_message = message;
	
	[self didChangeMessage: _message];
	
}

#pragma mark - Delegate Helpers

-(void)didChangeMessage: (NSString *) message {
	
	if ([self.delegate respondsToSelector:@selector(console:didChangeMessage:)]) {
		
		[self.delegate console: self didChangeMessage:message];
	}
}

@end
