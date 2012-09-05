//
//  BYAlertView.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/5/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import "BYAlertView.h"

@implementation BYAlertView

@synthesize completion=_completion;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil ];
    
    if (self) {
        
        va_list _arguments;
        va_start(_arguments, otherButtonTitles);
        
        for (NSString *key = otherButtonTitles; key != nil; key = (__bridge NSString *)va_arg(_arguments, void *)) {
            [self addButtonWithTitle:key];
        }
        va_end(_arguments);
    }
    return self;
}


- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
         completion:(void (^)(BOOL cancelled, NSInteger buttonIndex))completion
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil ];
    
    if (self) {
        _completion = completion;
        
        va_list _arguments;
        va_start(_arguments, otherButtonTitles);
        
        for (NSString *key = otherButtonTitles; key != nil; key = (__bridge NSString *)va_arg(_arguments, void *)) {
            [self addButtonWithTitle:key];
        }
        va_end(_arguments);
    }
    return self;
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    self.completion(buttonIndex==self.cancelButtonIndex, buttonIndex);
}

@end
