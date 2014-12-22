//
//  VGraph.h
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VGraph;

@protocol VGraphViewDelegate <NSObject>

- (void)didReqestNavigationToRoot:(NSUInteger)root sender:(id)sender;

@end

@interface VGraphView : UIView
@property (nonatomic, weak) id <VGraphViewDelegate> delegate;

- (id)initGraphViewWithGraph:(VGraph *)graph;
- (NSString *)getDomain;

@end
