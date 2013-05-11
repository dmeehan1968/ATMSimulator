
@protocol ATMConsole <NSObject>

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSArray *inputOptions;
@property (assign, nonatomic) NSInteger lastInputReceived;

-(void)didSelectInputOption: (NSInteger) index;

@end

@interface ATMConsole : NSObject <ATMConsole>


@end