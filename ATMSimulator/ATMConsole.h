
@protocol ATMConsoleDelegate <NSObject>

@end

@protocol ATMConsole <NSObject>

@property (strong, nonatomic) NSString *message;
@property (weak) id<ATMConsoleDelegate> delegate;

@end

@interface ATMConsole : NSObject <ATMConsole>

@end