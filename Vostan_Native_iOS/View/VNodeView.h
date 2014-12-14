//
//  VNodeView.h
//  Vostan_Native_iOS
//
//  Copyright (c) 2014 AUA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VNode.h"

@interface VNodeView : UIView

- (id)initWithNode:(VNode *)node;
- (void)loadImageAsync;

@end
