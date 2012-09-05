//
//  BYAlertView.h
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/5/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import <UIKit/UIKit.h>

/// stolen from: http://stackoverflow.com/questions/10082383/block-for-uialertviewdelegate

@interface BYAlertView : UIAlertView

- (id)initWithTitle:(NSString *)title message:(NSString *)message completion:(void (^)(BOOL cancelled, NSInteger buttonIndex))completion cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (id)initWithTitle:(NSString *)title message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@property (copy, nonatomic) void (^completion)(BOOL, NSInteger);


@end