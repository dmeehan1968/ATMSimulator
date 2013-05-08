//
//  ATMController.h
//  ATMSimulator
//
//  Created by Dave Meehan on 04/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATMConsole.h"
#import "ATMOperatorSwitch.h"

extern NSString * const ATMControllerMessageNotAvailable;
extern NSString * const ATMControllerMessageEnterCashBalance;

@interface ATMController : NSObject

@property (weak, nonatomic) id<ATMConsole> console;
@property (weak, nonatomic) id<ATMOperatorSwitch> operatorSwitch;

@end
