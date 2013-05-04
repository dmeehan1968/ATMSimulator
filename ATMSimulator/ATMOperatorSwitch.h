
@protocol ATMOperatorSwitch;

@protocol ATMOperatorSwitchDelegate <NSObject>

-(void) operatorSwitch: (id<ATMOperatorSwitch>) operatorSwitch didChangeToState: (BOOL) state;

@end

@protocol ATMOperatorSwitch <NSObject>

@property (weak, nonatomic) id<ATMOperatorSwitchDelegate> delegate;
@property (assign, nonatomic) BOOL state;

@end

@interface ATMOperatorSwitch : NSObject <ATMOperatorSwitch>

@end