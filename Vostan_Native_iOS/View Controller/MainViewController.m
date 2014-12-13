//
//  ViewController.m
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

#import "MainViewController.h"
#import "VModelHandler.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)onClick:(id)sender
{
  [[VModelHandler instance] testConnectToVostan];
}

@end
