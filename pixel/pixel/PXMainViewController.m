//
//  PXMainViewController.m
//  pixel-demo
//
//  Created by Cédric Raud on 09/05/12.
//  Copyright (c) 2012 Pixel. All rights reserved.
//

#import "PXMainViewController.h"

#import "PXViewController.h"


@interface PXMainViewController () {
    UIViewController    *_gameViewController;
}
@end

@implementation PXMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _gameViewController = [[PXViewController alloc] initWithNibName:@"PXViewController" bundle:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)doAction:(id)sender
{
    UIView* gameView = _gameViewController.view;
    gameView.frame = self.view.frame;
    [self.view addSubview:gameView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
