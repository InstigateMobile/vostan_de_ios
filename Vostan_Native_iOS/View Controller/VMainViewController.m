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

@interface VMainViewController () <VModelHandlerDelegate>

//@property (nonatomic, weak) IBOutlet UIView *placeholderView;
@property (nonatomic, strong) IBOutlet UIView *graphView;

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
    VGraphView *newGraph = [[VGraphView alloc] initGraphViewWithGraph:graph];
    [newGraph setFrame:_graphView.frame];
    [newGraph setNeedsDisplay
     ];
    [_graphView addSubview:newGraph];
  }];
}


@end
