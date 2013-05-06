//
//  ATMBindingManager.h
//  ATMSimulator
//
//  Created by Dave Meehan on 05/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATMBindingManager : NSObject

-(void) bindObserver: (id) observer keypath: (NSString *) observerKeypath toSubject: (id) subject keypath: (NSString *) subjectKeypath;
-(void) bindBothObserver: (id) observer keypath: (NSString *) observerKeypath toSubject: (id) subject keypath: (NSString *) subjectKeypath;

-(void)enable;
-(void)disable;

@end
