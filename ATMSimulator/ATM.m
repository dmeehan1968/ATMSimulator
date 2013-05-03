//
//  ATM.m
//  ATMSimulator
//
//  Created by Dave Meehan on 03/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import "ATM.h"

@implementation ATM

-(void)setConsole:(id<ATMConsole>)console {
    
    _console = console;
    _console.message = @"Not Available";
    
}

@end
