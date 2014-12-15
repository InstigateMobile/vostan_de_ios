//
//  VNodeView.h
//  Vostan_Native_iOS
//
//  Copyright (c) 2014 AUA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VNode.h"

@protocol VNodeViewDelegate <NSObject>

- (void)didTapNodeView:(id)sender;
- (void)didLongPressNodeView:(id)sender;

@end

@interface VNodeView : UIView
@property (nonatomic, weak) id <VNodeViewDelegate> delegate;

- (id)initWithNode:(VNode *)node;
- (void)loadImageAsync;
- (NSUInteger)getNodeID;

@end
