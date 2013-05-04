
@protocol ATMOperatorSwitchDelegate <NSObject>


@end

@protocol ATMOperatorSwitch <NSObject>

@property (weak, nonatomic) id<ATMOperatorSwitchDelegate> delegate;

@end