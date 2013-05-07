//
//  ATMBindingManager.h
//  ATMSimulator
//
//  Created by Dave Meehan on 05/05/2013.
//  Copyright (c) 2013 Dave Meehan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATMKeypath : NSObject

@property (strong, nonatomic) NSString *stringValue;

+(id) keypathWithString: (NSString *) stringValue expression: (void *) var;

@end

#define keypath(var) ([ATMKeypath keypathWithString: @#var expression: (void *)var])

@interface ATMBindingManager : NSObject

-(void) bindObserver: (id) observer keypath: (ATMKeypath *) observerKeypath toSubject: (id) subject keypath: (ATMKeypath *) subjectKeypath;

-(void) bindObserver: (id) observer keypath: (ATMKeypath *) observerKeypath toSubject: (id) subject keypath: (ATMKeypath *) subjectKeypath translator: (id (^)(id newValue)) translator;

-(void) bindBothObserver: (id) observer keypath: (ATMKeypath *) observerKeypath toSubject: (id) subject keypath: (ATMKeypath *) subjectKeypath;

-(void) bindBothObserver: (id) observer keypath: (ATMKeypath *) observerKeypath translator: (id (^)(id newValue)) observerTranslator toSubject: (id) subject keypath: (ATMKeypath *) subjectKeypath translator: (id (^)(id newValue)) subjectTranslator;

-(void)enable;
-(void)disable;

@end

