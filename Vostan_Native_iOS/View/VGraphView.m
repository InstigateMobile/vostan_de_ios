//
//  VGraph.m
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

#import "VGraphView.h"
#import "VNodeView.h"
#import "VGraph.h"
#import "VLink.h"
#import "VColor.h"

@interface VGraphView () <VNodeViewDelegate>
@property (strong) VGraph *graph;

@property (strong) NSMutableArray *nodeViews;

@end

@implementation VGraphView

- (id)initGraphViewWithGraph:(VGraph *)graph {
//  self = [super initWithFrame:CGRectMake(0, 0, 500, 500)];
  self = [super init];
  
  if (self && graph) {
    _graph = graph;
    _nodeViews = [@[] mutableCopy];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    for (id node in [_graph nodes]) {
      [_nodeViews addObject:[[VNodeView alloc] initWithNode:(VNode *)node]];
      [[_nodeViews lastObject] loadImageAsync];
      [(VNodeView *)[_nodeViews lastObject] setDelegate:self];
      [self addSubview:[_nodeViews lastObject]];
    }
  }
  return self;
}

- (NSString *)getDomain {
  return [_graph domain];
}

- (BOOL)autoresizesSubviews {
  return NO;
}

- (UIViewAutoresizing)autoresizingMask {
  return UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

//- (void)drawRect:(CGRect)rect {
//  // Drawing links
////    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
////    [shapeLayer setFrame:self.frame];
////    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
////    [shapeLayer setStrokeColor:[[UIColor redColor] CGColor]];
////    [shapeLayer setLineWidth:2];
////    [shapeLayer setLineJoin:kCALineJoinRound];
////  UIBezierPath *path;
////  for (VLink *link in [_graph links]) {
////    path = [UIBezierPath bezierPath];
////    
////    CGRect rect = [[_graph nodeWithID:[link nodeID]] nodeRect];
////    [path moveToPoint:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))];
////    CGRect linkedRect = [[_graph nodeWithID:[link linkedNodeID]] nodeRect];
////    [path moveToPoint:CGPointMake(CGRectGetMidX(linkedRect), CGRectGetMidY(rect))];
////    
////  }
////  [shapeLayer setPath:path.CGPath];
////  [[self layer] addSublayer:shapeLayer];
//}

#pragma mark - VNodeDelegate
- (void)didTapNodeView:(id)sender {
  VNodeView *nodeView = (VNodeView *)sender;
  [_delegate didReqestNavigationToRoot:[nodeView getNodeID] sender:self];
}

- (void)didLongPressNodeView:(id)sender {
  
}


@end
