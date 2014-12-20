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
      // Skip carousel nodes
      if ([(VNode *)node isCarousel]) {
        continue;
      }
      
      [_nodeViews addObject:[[VNodeView alloc] initWithNode:(VNode *)node]];
      [[_nodeViews lastObject] loadImageAsync];
      [(VNodeView *)[_nodeViews lastObject] setDelegate:self];
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

- (void)layoutSubviews {
  for (VNodeView *nodeView in _nodeViews) {
    [self addSubview:nodeView];
  }
}

- (void)drawRect:(CGRect)rect {
  if (!_graph) {
    return;
  }

  // Drawing links
  UIBezierPath *path = [UIBezierPath bezierPath];
  for (VLink *link in [_graph links]) {
    CGRect firstRect = [[_graph nodeWithID:[link nodeID]] nodeRect];
    CGRect secondRect = [[_graph nodeWithID:[link linkedNodeID]] nodeRect];
    
    if (CGRectIsEmpty(firstRect) || CGRectIsEmpty(secondRect)) {
      continue;
    }

    [path moveToPoint:CGPointMake(CGRectGetMidX(firstRect), CGRectGetMidY(firstRect))];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(secondRect), CGRectGetMidY(secondRect))];
  }
  
  CAShapeLayer *shapeLayer = [CAShapeLayer layer];
  [shapeLayer setPath:[path CGPath]];
  [shapeLayer setStrokeColor:[[UIColor nodeBorderColor] CGColor]];
  [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
  [shapeLayer setLineJoin:kCALineJoinRound];
  [shapeLayer setLineWidth:1.0];
  [self.layer addSublayer:shapeLayer];
}

#pragma mark - VNodeDelegate
- (void)didTapNodeView:(id)sender {
  VNodeView *nodeView = (VNodeView *)sender;
  [_delegate didReqestNavigationToRoot:[nodeView getNodeID] sender:self];
}

- (void)didLongPressNodeView:(id)sender {
  
}


@end
