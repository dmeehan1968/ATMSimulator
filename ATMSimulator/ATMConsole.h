
@protocol ATMConsole <NSObject>

@property (strong, nonatomic) NSString *message;
@property (weak) id delegate;

@end

@interface ATMConsole : NSObject <ATMConsole>

@end