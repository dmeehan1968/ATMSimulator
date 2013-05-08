
@protocol ATMConsole <NSObject>

@property (strong, nonatomic) NSString *message;

@end

@interface ATMConsole : NSObject <ATMConsole>

@end