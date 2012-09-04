//
//  BYQuizViewController.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/4/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import "BYQuizViewController.h"
#import "BYGameEngine.h"

@interface BYQuizViewController ()
-(IBAction)quitButtonHandler: (id)sender;
-(IBAction)helpButtonHandler: (id)sender;

- (void) longPressGestureRecognizerHandler: (UIGestureRecognizer*) gesture;
@end

@implementation BYQuizViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _gameEngine = [[BYGameEngine alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)quitButtonHandler:(id)sender {
    /// pop to main view controller
}

- (IBAction)helpButtonHandler:(id)sender {
    /// show some help
}

- (void) longPressGestureRecognizerHandler:(UIGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        
    }
}

@end