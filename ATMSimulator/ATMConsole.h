
@protocol ATMConsole <NSObject>

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSArray *inputOptions;

@end

@interface ATMConsole : NSObject <ATMConsole>

@end