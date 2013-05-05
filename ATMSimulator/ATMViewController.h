//
//  ATMViewController.h
//  ATMSimulator
//
//  Created by Dave Meehan on 02/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATMController.h"
#import "ATMConsole.h"

@interface ATMViewController : UIViewController <ATMConsoleDelegate>

@property (strong, nonatomic) ATMController *atmController;
@property (strong, nonatomic) ATMOperatorSwitch *operatorSwitch;
@property (strong, nonatomic) ATMConsole *console;

@property (strong, nonatomic) IBOutlet UISwitch *operatorSwitchUI;
@property (strong, nonatomic) IBOutlet UILabel *messageUI;

- (IBAction)didChangeValueForOperatorSwitchUI:(id)sender;

@end
