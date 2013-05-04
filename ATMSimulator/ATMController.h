//
//  ATMController.h
//  ATMSimulator
//
//  Created by Dave Meehan on 04/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATMConsole.h"

@interface ATMController : NSObject

@property (weak) id<ATMConsole> console;

@end
