
@class ATMConsole;

@protocol ATMConsoleDelegate <NSObject>

-(void) console: (ATMConsole *) console didChangeMessage: (NSString *) message;

@end

@protocol ATMConsole <NSObject>

@property (strong, nonatomic) NSString *message;
@property (weak, readonly) id<ATMConsoleDelegate> delegate;

@end

@interface ATMConsole : NSObject <ATMConsole>

-(id) initWithDelegate: (id<ATMConsoleDelegate>) delegate;

@end