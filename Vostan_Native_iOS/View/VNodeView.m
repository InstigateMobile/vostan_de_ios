//
//  VNodeView.m
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

#import "VNodeView.h"
#import "VColor.h"

@interface VNodeView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIWebView *bodyWebView;
@property (nonatomic, strong) VNode *node;
@end

@implementation VNodeView

- (id)initWithNode:(VNode *)node {
  self = [super initWithFrame:[node nodeRect]];
  
  if (self) {
    _node = node;
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
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
    
    if (![_bodyWebView isHidden]) {
      [_bodyWebView loadHTMLString:[_node body] baseURL:nil];
    }
    
    _imageView = [[UIImageView alloc] init];
    [_imageView setHidden:![_node imageVisible]];
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:_imageView];
    
    [self addGestureRecognizers];
  }
  return self;
}

- (void)layoutSubviews {
  [_titleLabel setFrame:[_node titleRect]];
  [_imageView setFrame:[_node imageRect]];
  [_bodyWebView setFrame:[_node bodyRect]];
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
