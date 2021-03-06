//
//  BYQuizViewController.m
//  Geo_Quiz
//
//  Created by myeyesareblind on 9/4/12.
//  Copyright (c) 2012 MYBR. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "BYQuizViewController.h"
#import "BYGameEngine.h"
#import "BYAlertView.h"
#import "BYAnnotation.h"
#import "BYSoundManager.h"

const float CBY_viewUpdateTimerInterval     = 0.2f;
const int   CBY_annotationExlamationMark    = 5655;
const int   CBY_annotationQuestionMark      = 5412;

@interface BYQuizViewController ()
-(IBAction)quitButtonHandler: (id)sender;
-(IBAction)helpButtonHandler: (id)sender;
-(IBAction)pauseButtonHandler: (id)sender;


- (void) tapGestureHandle: (UIGestureRecognizer*) gesture;

- (void) _updateViews;
- (void) _removeMapViewAnnotations;
- (void) _addQuestionMarkAnnotationAtPoint: (CLLocationCoordinate2D) pnt;
- (void) _addExlamationMarkAnnotationAtPoint: (CLLocationCoordinate2D) pnt;
- (void) _initGame;


- (void) pauseGame;
- (void) resumeGame;


- (void) applicationDidEnterForeGround;
- (void) applicationDidEnterBackGround;

@end

@implementation BYQuizViewController

@synthesize mapView = _mapView;
@synthesize helpButton, quitButton, pauseButton, timerLabel, quizTaskLabel;

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initGame];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self _initGame];
        // Custom initialization
    }
    return self;
}

- (void) _initGame {
    
    _gameEngine = [[BYGameEngine alloc] init];
    _gameEngine.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackGround)
                                                 name:NBY_ApplicationDidEnterBackGround
                                               object:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterForeGround)
                                                 name:NBY_ApplicationDidEnterForeGround
                                               object:NULL];

    
    [_gameEngine startNewGame];
    [_gameEngine startNewQuiz];
    
    _viewRefreshTimer = [NSTimer scheduledTimerWithTimeInterval:CBY_viewUpdateTimerInterval
                                                         target:self
                                                       selector:@selector(_updateViews)
                                                       userInfo:NULL
                                                        repeats:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(tapGestureHandle:)];
    
    [_mapView addGestureRecognizer: tapGesture];
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

/// main routine to retrieve bgd state and initial run
- (void) viewWillAppear:(BOOL)animated {
}


- (void) _updateViews {
    timerLabel.text = [NSString stringWithFormat:@"%f", _gameEngine.quizTimeLeft];
    quizTaskLabel.text = _gameEngine.quizTask;
}


- (IBAction)quitButtonHandler:(id)sender {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [_gameEngine quitQuiz];
    
    [_viewRefreshTimer invalidate];
    _viewRefreshTimer = NULL;
    
    _onQuizFinishedBlock = NULL;
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

- (IBAction)helpButtonHandler:(id)sender {
    /// show some help
}

- (IBAction)pauseButtonHandler:(id)sender {
    if (_gameEngine.gameQuizState == BYGameQuizState_Paused) {
        [self resumeGame];
    } else if (_gameEngine.gameQuizState == BYGameQuizState_Running) {
        [self pauseGame];
    }
}

- (void) tapGestureHandle:(UIGestureRecognizer *)gesture {
    if (_gameEngine.gameQuizState == BYGameQuizState_Running) {
        if (gesture.state == UIGestureRecognizerStateRecognized) {
            CGPoint onViewPoint = [gesture locationInView: _mapView];
            CLLocationCoordinate2D onMapPoint = [_mapView convertPoint:onViewPoint
                                                  toCoordinateFromView:_mapView];
            
            BYLOG(@"onMapCoordinate: %@", NSStringFromCLLocationCoordinate2d(onMapPoint));
            [self _addQuestionMarkAnnotationAtPoint: onMapPoint];
            [_gameEngine processQuizAnswerCoordinate: onMapPoint];
        }
    } else {
        BYLOG(@"cant process tap gesture while game is not running");
    }
}


- (void) applicationDidEnterForeGround {
    [self resumeGame];
}


- (void) applicationDidEnterBackGround {
    [self pauseGame];
}


- (void) pauseGame {
    [_gameEngine pauseQuiz];
}


- (void) resumeGame {
    [_gameEngine startQuiz];
}

#pragma mark - BYGameEngineDelegate

- (void) BYGameEngineQuizStarted:(BYGameEngine *)engine {
    [self _removeMapViewAnnotations];
    [self _updateViews];
}


- (void) BYGameEngineTimeRanOut:(BYGameEngine *)engine {
    /// same
    [self BYGameEngineQuizFinished: engine];
}


- (void) BYGameEngineQuizFinished:(BYGameEngine *)engine {
    [self _updateViews];
    
    /// wait for scroll animation of mapview to finish

    __weak BYGameEngine *gn = _gameEngine;
    
    _onQuizFinishedBlock = ^{
    NSString *pointsInformation = [NSString stringWithFormat: NSLocalizedString(@"kPoint gained %d", NULL), _gameEngine.pointsForLastQuiz ];
    
    /// show alertView with points gained and next button
    /// if this quiz was last one, then show finish dialogue
    BYAlertView* alertView = [[BYAlertView alloc] initWithTitle:NSLocalizedString(@"kQuizFinished_alertViewTitle", NULL)
                                                        message:pointsInformation
                                                     completion:^(BOOL cancel, NSInteger buttonIndex){
                                                         if ([gn canStartNewQuiz])  /// this quiz might be last one
                                                             [gn startNewQuiz];
                                                     }
                                              cancelButtonTitle:NSLocalizedString(@"kOK", NULL)
                                              otherButtonTitles:nil];
    [alertView show];
    };
}


- (void) BYGameEngineLastQuizFinished:(BYGameEngine *)engine {
    [self _updateViews];
    
    __weak BYGameEngine *gn = _gameEngine;
    __weak BYQuizViewController *weakSelf = self;
    /// wait for scroll animation of mapview to finish
    _onQuizFinishedBlock = ^{
    NSString *pointsInformation = [NSString stringWithFormat: NSLocalizedString(@"kPoint gained %d", NULL), _gameEngine.pointsForLastQuiz ];
            
    /// show alertView with points gained and next button
    /// if this quiz was last one, then show finish dialogue
    BYAlertView* alertView = [[BYAlertView alloc] initWithTitle:NSLocalizedString(@"kQuizFinished_alertViewTitle", NULL)
                                                        message:pointsInformation
                                                     completion:^(BOOL cancel, NSInteger buttonIndex ){

                                                             /// propose to enter username and show points / overall place
                                                             NSString *pointsInformation = [NSString stringWithFormat: NSLocalizedString(@"kPoint gained %d", NULL), _gameEngine.totalPoints];
                                                             BYAlertView* newGameAlertView = [[BYAlertView alloc] initWithTitle:NSLocalizedString(@"kGaneFinished_alertViewTitle", NULL)
                                                                                                                        message:pointsInformation
                                                                                                                     completion:^(BOOL cancel, NSInteger buttonIndex){
                                                                                                                         if (cancel) {
                                                                                                                             [weakSelf quitButtonHandler: NULL];
                                                                                                                         } else {
                                                                                                                             [gn startNewGame];
                                                                                                                             [gn startNewQuiz];
                                                                                                                         }
                                                                                                                     }
                                                                                                              cancelButtonTitle:NSLocalizedString(@"kQuit", NULL)
                                                                                                              otherButtonTitles:NSLocalizedString(@"kStartNewGame_alertViewButton", NULL), nil];
                                                             [newGameAlertView show];
                                                     }
                                              cancelButtonTitle:NSLocalizedString(@"kOK", NULL)
                                              otherButtonTitles:nil];
        [alertView show];
    }; /// block
}


- (void) BYGameEngineProcessQuizAnswerCoordinateAnimation:(CLLocationCoordinate2D)quizAnswerCoord {
    [self _addExlamationMarkAnnotationAtPoint: quizAnswerCoord];
    if ( CLLocationCoordinateAreEqual(_mapView.centerCoordinate, quizAnswerCoord) ) {
        _onQuizFinishedBlock();
        _onQuizFinishedBlock = NULL;
    } else {
        [_mapView setCenterCoordinate: quizAnswerCoord
                             animated: YES];
    }
}


#pragma mark - MKMapView methods
- (MKAnnotationView*) mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString * const exlViewID = @"!";
    static NSString * const queViewID = @"?";
    
    BYAnnotation*  ann      = (BYAnnotation*) annotation;
    NSString*      viewID   = ann.tag == CBY_annotationExlamationMark ? exlViewID : queViewID;
    
    MKAnnotationView *annView = [_mapView dequeueReusableAnnotationViewWithIdentifier: viewID];
    if (annView == NULL) {
        annView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:viewID];
        UIImage * im = [UIImage imageNamed: [NSString stringWithFormat:@"%@.png", viewID]];
        annView.image = im;
    }
    annView.annotation = annotation;
    return annView;
}


- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    if (animated) {
        if (_onQuizFinishedBlock) {
            _onQuizFinishedBlock();
            _onQuizFinishedBlock = NULL;
        }
    }
}

- (void) _removeMapViewAnnotations {
    NSArray *annots = [_mapView annotations];
    [_mapView removeAnnotations:annots];
}


- (void) _addExlamationMarkAnnotationAtPoint:(CLLocationCoordinate2D)pnt {
    
    [_mapView addAnnotation: [[BYAnnotation alloc] initWithCoordinate:pnt
                                                                  Tag:CBY_annotationExlamationMark]];
    [_mapView setNeedsDisplay];
    
    [[BYSoundManager soundManager] playSoundEffect: SBY_ExclamationMarkPlacedSound];
}


- (void) _addQuestionMarkAnnotationAtPoint:(CLLocationCoordinate2D)pnt {
    [_mapView addAnnotation: [[BYAnnotation alloc] initWithCoordinate:pnt
                                                                  Tag:CBY_annotationQuestionMark]];
    [_mapView setNeedsDisplay];
    
    [[BYSoundManager soundManager] playSoundEffect: SBY_QuestionMarPlacedkSound];
}


- (void) dealloc {
    
}
@end