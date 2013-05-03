//
//  ATM.h
//  ATMSimulator
//
//  Created by Dave Meehan on 03/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATMConsole.h"

@interface ATM : NSObject

@property (weak, nonatomic) id<ATMConsole> console;
@property (assign, nonatomic) CGFloat cashBalance;

-(void)powerOn;

@end
