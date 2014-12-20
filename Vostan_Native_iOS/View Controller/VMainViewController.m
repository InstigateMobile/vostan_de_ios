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
#import "GGGTableViewCell.h"

@interface VMainViewController () <VModelHandlerDelegate, VGraphViewDelegate,
UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate>

@property (nonatomic, strong) IBOutlet UIView *graphView;
@property (nonatomic, strong) VGraphView *currentGraph;

@property (nonatomic, strong) NSString *selectedGGG;
@property (nonatomic, strong) NSMutableArray *gggArray;
@property (nonatomic, strong) UITableView *gggListVeiw;
@property (nonatomic, strong) UIPopoverController *gggListPopover;


@end

@implementation VMainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [[VModelHandler instance] setDelegate:self];

  _selectedGGG = nil;
  _gggArray = [NSMutableArray arrayWithObjects:
               @"ggg.vostan.net",
               @"ggg.instigate.am",
               @"ggg.instigatemobile.com",
               @"ggg.instigate-training-center.am",
               @"ggg.instigateconsulting.com",
               @"ggg.i-gorc.am",
               @"ggg.instigaterobotics.com",
               @"ggg.improve.am",
               @"ggg.yerevak.com",
               @"ggg.proximusda.com",
               @"ggg.tri.am",
               nil];
  
  // Setup list table
  CGRect gggListRect = CGRectMake(0, 0, GGGTableViewCellWidth, GGGTableViewCellHeight * _gggArray.count);
  _gggListVeiw = [[UITableView alloc] initWithFrame:gggListRect];
  [_gggListVeiw setBounces:NO];
  [_gggListVeiw setDataSource:self];
  [_gggListVeiw setDelegate:self];
  [_gggListVeiw registerNib:[UINib nibWithNibName:[GGGTableViewCell reuseIdentifier] bundle:[NSBundle mainBundle]]forCellReuseIdentifier:[GGGTableViewCell reuseIdentifier]];
  
  // Setup popover
  UIViewController *popoverContent = [[UIViewController alloc] init];
  UIView *popoverView = [[UIView alloc] initWithFrame:gggListRect];
  [popoverView addSubview:_gggListVeiw];
  [popoverContent setView:popoverView];
  [popoverContent setPreferredContentSize:gggListRect.size];
  
  _gggListPopover = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
  [_gggListPopover setDelegate:self];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

#pragma mark -
- (IBAction)onClick:(id)sender {
  if ([_gggListPopover isPopoverVisible]) {
    [_gggListPopover dismissPopoverAnimated:YES];
    return;
  }
  
  CGRect parentFrame = [(UIButton *)sender frame];
  parentFrame.origin.y = 15;
  [_gggListPopover  presentPopoverFromRect:parentFrame
                                    inView:self.view
                  permittedArrowDirections:UIPopoverArrowDirectionDown
                                  animated:YES];
}

- (void)navigateToRoot:(NSUInteger)root withDomain:(NSString *)domain {
  [[VModelHandler instance] requestGraphWithRoot:(int)root fromGGG:domain completion:^(VGraph *graph) {
    if (_currentGraph) {
      [_currentGraph removeFromSuperview];
    }
    _currentGraph = [[VGraphView alloc] initGraphViewWithGraph:graph];
    [_currentGraph setFrame:_graphView.frame];
    [_currentGraph setDelegate:self];
    [_graphView addSubview:_currentGraph];
  }];
}

#pragma mark - VGraphViewDelegate
- (void)didReqestNavigationToRoot:(NSUInteger)root sender:(id)sender {
  VGraphView *graphView = (VGraphView *)sender;
  [self navigateToRoot:(int)root withDomain:[graphView getDomain]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_gggArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  GGGTableViewCell *cell = [_gggListVeiw dequeueReusableCellWithIdentifier:[GGGTableViewCell reuseIdentifier]];
  
  if(cell == nil) {
    cell = [[GGGTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[GGGTableViewCell reuseIdentifier]];
  }
  
  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  [cell setDomain:[_gggArray objectAtIndex:indexPath.row]];
  
  return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return GGGTableViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [_gggListPopover dismissPopoverAnimated:YES];
  
  NSString *selectedDomain = [_gggArray objectAtIndex:indexPath.row];
  [self navigateToRoot:1 withDomain:selectedDomain];
}


@end
