//
//  VNodeView.m
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

#import "VNodeView.h"
#import "VColor.h"

@interface VNodeView ()

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIWebView *bodyWebView;
@property (nonatomic, strong) VNode *nodeObj;
@end

@implementation VNodeView

- (id)initWithNode:(VNode *)node {
  self = [super initWithFrame:[node nodeRect]];
  
  if (self) {
    _nodeObj = node;
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    _titleLabel = [[UILabel alloc] initWithFrame:[_nodeObj titleRect]];
    [_titleLabel setText:[_nodeObj title]];
    [_titleLabel setHidden:![_nodeObj titleVisible]];
    [self setTitleStyle];
    [self addSubview:_titleLabel];
    
    _bodyWebView = [[UIWebView alloc] initWithFrame:[_nodeObj bodyRect]];
    [_bodyWebView setHidden:![_nodeObj bodyVisible]];
    [self addSubview:_bodyWebView];
    
    
    if (![_bodyWebView isHidden]) {
      [_bodyWebView loadHTMLString:[_nodeObj body] baseURL:nil];
    }
    
    _imageView = [[UIImageView alloc] initWithFrame:[_nodeObj imageRect]];
    [_imageView setHidden:![_nodeObj imageVisible]];
    [self addSubview:_imageView];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  // Setting border
  [[self layer] setCornerRadius:5.0];
  [[self layer] setBorderWidth:2.0];
  [[self layer] setBorderColor:[[UIColor nodeBorderColor] CGColor]];
}

- (void)setTitleStyle {
  [_titleLabel setTextColor:[UIColor nodeTitleColor]];
  [_titleLabel setFont:[UIFont fontWithName:@"Verdana" size:20]];
}

- (void)loadImageAsync {
  __block UIImageView *blockimage = _imageView;
  __block NSString *url = [NSString stringWithFormat:@"http://ggg.instigate-training-center.am/%@",[_nodeObj imageUrl]];
  
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,  0ul);
  dispatch_async(queue, ^{
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    dispatch_sync(dispatch_get_main_queue(), ^{
      blockimage.image = [UIImage imageWithData:imageData];
      blockimage = nil;
    });
  });
}



@end
