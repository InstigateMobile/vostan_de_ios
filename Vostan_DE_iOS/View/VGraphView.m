//
//  VGraph.m
//  Vostan_DE_iOS
//
//  This file is part of Vostan framework.
//  Vostan is an open-source Information Management Platform that can be used to
//  build GGG (web 3.0) web-sites and presentations using mind-map based
//  human-machine-interaction paradigm and information management.
//  Project home page [http://ggg.vostan.net]
//  Copyright (c) 2011-2014 Instigate Mobile cjsc, [http://ggg.instigatemobile.com]
//  Vostan is a free software: you can redistribute it and/or modify it under the
//  terms of the GNU Affero General Public License as published by the Free
//  Software Foundation, either version 3 of the License, or (at your option) any
//  later version.
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY
//  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
//  PARTICULAR PURPOSE. See the GNU Affero General Public License for more
//  details.
//  You should have received a copy of the GNU Affero General Public License
//  along with this program. If not, see [http://www.gnu.org/licenses/].
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
    VNode *firstNode = [_graph nodeWithID:[link nodeID]];
    VNode *secondNode = [_graph nodeWithID:[link linkedNodeID]];
    CGRect firstRect = [firstNode nodeRect];
    CGRect secondRect = [secondNode nodeRect];
    
    // Skip carousel links
    if (CGRectIsEmpty(firstRect) || CGRectIsEmpty(secondRect)
        || [firstNode isCarousel] || [secondNode isCarousel]) {
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
