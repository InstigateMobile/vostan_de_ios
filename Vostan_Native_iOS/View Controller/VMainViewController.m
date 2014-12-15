//
//  ViewController.m
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

#import "VMainViewController.h"
#import "VModelHandler.h"
#import "VNode.h"
#import "VNodeView.h"
#import "VGraphView.h"

@interface VMainViewController () <VModelHandlerDelegate, VGraphViewDelegate>

//@property (nonatomic, weak) IBOutlet UIView *placeholderView;
@property (nonatomic, strong) IBOutlet UIView *graphView;
@property (nonatomic, strong) VGraphView *currentGraph;

@property (nonatomic, strong) NSString *selectedGGG;

@end

@implementation VMainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [[VModelHandler instance] setDelegate:self];
  
  //"https://edu.vostan.net/erp/vostan_DE_iOS_native_app/api.php/map/root/5/lang/en"
  _selectedGGG = @"ggg.instigate-training-center.am";
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL) animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (IBAction)onClick:(id)sender {
  [[VModelHandler instance] requestGraphWithRoot:1 fromGGG:_selectedGGG completion:^(VGraph *graph) {
    if (_currentGraph) {
      [_currentGraph removeFromSuperview];
    }
    _currentGraph = [[VGraphView alloc] initGraphViewWithGraph:graph];
    [_currentGraph setFrame:_graphView.frame];
//    [_currentGraph setNeedsDisplay];
    [_currentGraph setDelegate:self];
    [_graphView addSubview:_currentGraph];
  }];
}

#pragma mark - VGraphViewDelegate
- (void)didReqestNavigationToRoot:(NSUInteger)root sender:(id)sender {
  VGraphView *graphView = (VGraphView *)sender;
  [[VModelHandler instance] requestGraphWithRoot:(int)root fromGGG:[graphView getDomain] completion:^(VGraph *graph) {
    if (_currentGraph) {
      [_currentGraph removeFromSuperview];
    }
    _currentGraph = [[VGraphView alloc] initGraphViewWithGraph:graph];
    [_currentGraph setFrame:_graphView.frame];
    [_currentGraph setDelegate:self];
    [_graphView addSubview:_currentGraph];
  }];
}


@end
