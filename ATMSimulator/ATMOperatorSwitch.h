
@protocol ATMOperatorSwitch;

@protocol ATMOperatorSwitchDelegate <NSObject>

-(void) operatorSwitch: (id<ATMOperatorSwitch>) operatorSwitch didChangeToState: (BOOL) state;

@end

@protocol ATMOperatorSwitch <NSObject>

@property (weak, nonatomic) id<ATMOperatorSwitchDelegate> delegate;

@end

@interface ATMOperatorSwitch : NSObject <ATMOperatorSwitch>

@property (weak, nonatomic) id<ATMOperatorSwitchDelegate> delegate;

@end