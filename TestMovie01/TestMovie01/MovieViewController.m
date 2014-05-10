//
//  MovieViewController.m
//  TestMovie01
//
//  Created by WAYNE SMALL on 5/10/14.
//  Copyright (c) 2014 WAYNE SMALL. All rights reserved.
//

#import "MovieViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MovieViewController ()

@property (nonatomic, strong) MPMoviePlayerController *player;

@end

@implementation MovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 60, 200, 40)];
    [label setText:@"Wayne's Movie Player"];
    [self.view addSubview:label];
    
    //NSBundle *bundle = [NSBundle mainBundle];
    //NSString *moviePath = [bundle pathForResource:@"MovieAssets.bundle/homemoviemp4" ofType:@"mp4"];
    //NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
    NSString *moviePath = @"http://www.wowza.com/_h264/BigBuckBunny_115k.mov";
    NSURL *movieURL = [NSURL URLWithString:moviePath];
    NSLog(@"WWWWWW %@", moviePath);
    //NSURL *movieURL = [NSURL fileURLWithPath:@"MovieAssets.bundle/homemovie.mov"];
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    [self installMovieNotificationObservers];
    self.player.view.frame = CGRectMake(10, 200, 300, 200);
    [self.player prepareToPlay];
    [self.view addSubview:self.player.view];
    //[self.player play];
}

- (void)installMovieNotificationObservers
{
    MPMoviePlayerController *player = self.player;
    
    
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didEnterFullscreen:)
                                                 name:MPMoviePlayerDidEnterFullscreenNotification
                                               object:player];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willExitFullscreen:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:player];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didExitFullscreen:)
                                                 name:MPMoviePlayerDidExitFullscreenNotification
                                               object:player];
}

#pragma mark - Movie Notification Handlers

- (void)moviePlayBackDidFinish:(NSNotification *)notification
{
    NSNumber *reason = [notification userInfo][MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
	switch ([reason integerValue]) {
		case MPMovieFinishReasonPlaybackEnded:
            NSLog(@"moviePlayBackDidFinish Playback Ended");
			break;
		case MPMovieFinishReasonPlaybackError:
            NSLog(@"moviePlayBackDidFinish Playback Error");
			break;
		case MPMovieFinishReasonUserExited:
            NSLog(@"moviePlayBackDidFinish User Exited");
			break;
		default:
            NSLog(@"moviePlayBackDidFinish Unknown");
			break;
	}
}

- (void)didEnterFullscreen:(NSNotification *)notification
{
    NSLog(@"didEnterFullscreen");
}

- (void)willExitFullscreen:(NSNotification*)notification
{
    NSLog(@"willExitFullscreen");
}

- (void)didExitFullscreen:(NSNotification*)notification
{
    NSLog(@"didExitFullscreen");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
