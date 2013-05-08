
@protocol ATMOperatorSwitch <NSObject>

@property (assign, nonatomic) BOOL state;

@end

@interface ATMOperatorSwitch : NSObject <ATMOperatorSwitch>

@end