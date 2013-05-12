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
extern NSString * const ATMControllerMessageInsertCard;
extern NSString * const ATMControllerMessageInvalidInput;

@interface ATMController : NSObject

@property (weak, nonatomic) NSObject<ATMConsole> *console;
@property (weak, nonatomic) NSObject<ATMOperatorSwitch> *operatorSwitch;

@property (assign, nonatomic) NSInteger cashBalance;

@end
