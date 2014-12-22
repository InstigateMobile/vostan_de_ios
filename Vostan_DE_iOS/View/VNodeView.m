//
//  VNodeView.m
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

#import "VNodeView.h"
#import "VColor.h"
#import "VTitleLabel.h"

@interface VNodeView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIWebView *bodyWebView;
@property (nonatomic, strong) UILabel *tagsLabel;
@property (nonatomic, strong) UILabel *bulletsLabel;
@property (nonatomic, strong) VNode *node;
@end

@implementation VNodeView

- (id)initWithNode:(VNode *)node {
  self = [super initWithFrame:[node nodeRect]];
  
  if (self) {
    _node = node;
    
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setClipsToBounds:YES];
    
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setText:[_node title]];
    [_titleLabel setHidden:![_node titleVisible]];
    [self setTitleStyle];
    [self addSubview:_titleLabel];
    
    _bodyWebView = [[UIWebView alloc] init];
    [_bodyWebView setHidden:![_node bodyVisible]];
    [self addSubview:_bodyWebView];
    
    // Hack to make webView scrollable
    for (id subview in _bodyWebView.subviews) {
      if ([subview isKindOfClass: [UIScrollView class]]) {
        ((UIScrollView *)subview).scrollEnabled = YES;
        break;
      }
    }
    
    [_bodyWebView setBackgroundColor:[UIColor whiteColor]];
    if (![_bodyWebView isHidden]) {
      [_bodyWebView loadHTMLString:[_node body] baseURL:nil];
    }
    
    _imageView = [[UIImageView alloc] init];
    [_imageView setHidden:![_node imageVisible]];
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:_imageView];
    
    _tagsLabel = [[UILabel alloc] init];
    [_tagsLabel setText:[_node tags]];
    [_tagsLabel setFont:[UIFont fontWithName:@"Cochin-Bold" size:12]];
    [_tagsLabel setTextColor:[UIColor darkGrayColor]];
    [_tagsLabel setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin];
    [self addSubview:_tagsLabel];
    
    if (![_node isLeaf]) {
      _bulletsLabel = [[UILabel alloc] init];
      [_bulletsLabel setText:@"..."];
      [_bulletsLabel setTextColor:[UIColor darkGrayColor]];
      [_bulletsLabel setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin];
      [self addSubview:_bulletsLabel];
    }
    
    [self addGestureRecognizers];
  }
  return self;
}

- (void)layoutSubviews {
  [_titleLabel setFrame:[_node titleRect]];
  [_titleLabel sizeToFitFixedWidth:CGRectGetWidth([_node titleRect])];
  
  [_imageView setFrame:[_node imageRect]];
  [_bodyWebView setFrame:[_node bodyRect]];
  
  [_tagsLabel sizeToFit];
  [_tagsLabel setFrame:CGRectMake(CGRectGetWidth([self frame]) - CGRectGetWidth([_tagsLabel frame]) - 5, 2,
                                  CGRectGetWidth([_tagsLabel frame]), CGRectGetHeight([_tagsLabel frame]))];
  
  if (![_node isLeaf]) {
    [_bulletsLabel setFrame:CGRectMake(CGRectGetWidth([self frame]) - 25,
                                       CGRectGetHeight([self frame]) - 25, 20, 20)];
  }
}

- (void)drawRect:(CGRect)rect {
  // Setting border
  [[self layer] setCornerRadius:5.0];
  [[self layer] setBorderWidth:2.0];
  [[self layer] setBorderColor:[[UIColor nodeBorderColor] CGColor]];
}

- (void)setTitleStyle {
  [_titleLabel setTextColor:[UIColor nodeTitleColor]];
  [_titleLabel setFont:[UIFont fontWithName:@"Cochin-Bold" size:19]];
  [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
  [_titleLabel sizeToFit];
}

- (NSUInteger)getNodeID {
  return [_node nodeID];
}

- (void)loadImageAsync {
  __block UIImageView *blockimage = _imageView;
  __block NSString *url = [NSString stringWithFormat:@"http://%@/%@", [_node domain], [_node imageUrl]];
  
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
  dispatch_async(queue, ^{
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    dispatch_sync(dispatch_get_main_queue(), ^{
      blockimage.image = [UIImage imageWithData:imageData];
      blockimage = nil;
    });
  });
}

- (void)addGestureRecognizers {
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                      action:@selector(handleTap:)];
  [self addGestureRecognizer:tap];

  UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleLongPress:)];
  [longPress setMinimumPressDuration:0.5]; //seconds
  [self addGestureRecognizer:longPress];
}

#pragma mark -
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
  if ([_node isLeaf]) {
    return;
  }
  
  if (_delegate && [_delegate respondsToSelector:@selector(didTapNodeView:)]) {
    [_delegate didTapNodeView:self];
  }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer {
  if (_delegate && [_delegate respondsToSelector:@selector(didLongPressNodeView:)]) {
    [_delegate didLongPressNodeView:self];
  }
}



@end
