
#import "ATMOperatorSwitch.h"

@implementation ATMOperatorSwitch
{}
@synthesize state = _state;
@synthesize delegate = _delegate;

#pragma mark - State

-(void)setState:(BOOL)state {
	
	_state = state;
	
	[self didChangeToState: _state];
	
}

#pragma mark - Delegate Helpers

-(void)didChangeToState: (BOOL) state {
	
	if ([self.delegate respondsToSelector:@selector(operatorSwitch:didChangeToState:)]) {
		
		[self.delegate operatorSwitch:self didChangeToState:state];
	}
	
}
@end