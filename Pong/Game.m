//
//  Game.m
//  Pong
//
//  Created by IT-Högskolan on 2015-03-01.
//  Copyright (c) 2015 IT-Högskolan. All rights reserved.
//

#import "Game.h"

@interface Game ()

@end

@implementation Game

- (IBAction)EndGame:(id)sender {
    timer = nil;
    [[self navigationController] popViewControllerAnimated: YES];
}

-(void)Collision;{
    
    
    if (CGRectIntersectsRect(Ball.frame, Player.frame)) {
        Y = arc4random() %3;
        Y = Y + Speed;
        Y = 0 - Y;
        if (Ball.center.x < (Player.center.x - 18)) {
            X = X - 2 - arc4random() %4;
        }
        AudioServicesPlaySystemSound(PlaySoundID);
    }
    if (CGRectIntersectsRect(Ball.frame, Computer.frame)) {
        Y = arc4random() %3;
        Y = Y + Speed;
        if (Ball.center.x < (Player.center.x + 18)) {
            X = X + 2 + arc4random() %4;
        }
        AudioServicesPlaySystemSound(PlaySoundID);
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    int cc = Player.center.y;
    UITouch *Drag = [[event allTouches] anyObject];
    Player.center = [Drag locationInView:self.view];
    
    if (Player.center.y != cc) {
        Player.center = CGPointMake(Player.center.x, cc);
    }
    if (Player.center.x < LeftBoard.center.x + 43) {
        Player.center = CGPointMake(LeftBoard.center.x + 43, Player.center.y);
    }
    if (Player.center.x > RightBoard.center.x - 43) {
        Player.center = CGPointMake(RightBoard.center.x - 43, Player.center.y);
    }
}

-(void)ComputerMovement{
    
    if (Computer.center.x > Ball.center.x) {
        Computer.center = CGPointMake(Computer.center.x - 2, Computer.center.y);
    }
    if (Computer.center.x < Ball.center.x) {
        Computer.center = CGPointMake(Computer.center.x + 2, Computer.center.y);
    }
    if (Computer.center.x < LeftBoard.center.x + 43) {
        Computer.center = CGPointMake(LeftBoard.center.x + 43, Computer.center.y);
    }
    if (Computer.center.x > RightBoard.center.x - 43) {
        Computer.center = CGPointMake(RightBoard.center.x - 43, Computer.center.y);
    }
}

-(IBAction)StartButton:(id)sender{
    
    StartButton.hidden = YES;
    ComputerScore.hidden = YES;
    PlayerScore.hidden = YES;
    Exit.hidden = YES;
    Speed++;
    
    Y = arc4random() %6;
    Y = Y - 3;
    X = arc4random() %6;
    X = X - 3;
    
    if (Y == 0) {
        Y = 1;
    }
    if (X == 0) {
        X = 1;
    }
}

-(void)BallMovement{
    [self Collision];
    [self ComputerMovement];
    Ball.center = CGPointMake(Ball.center.x + X, Ball.center.y + Y);
    
    if (Ball.center.x < (RightBoard.center.x - 24)) {
        X = 0 - X;
    }
    if (Ball.center.x > (LeftBoard.center.x + 24)) {
        X = 0 - X;
    }
    
    if (Ball.center.y < Computer.center.y) {
        ScorePlayer++;
        PlayerScore.text = [NSString stringWithFormat:@"%i",ScorePlayer];
        PlayerScore.hidden = NO;
        ComputerScore.hidden = NO;
        StartButton.hidden = NO;
        Exit.hidden = NO;
        X = 0;
        Y = 0;
        Ball.center = CGPointMake(Background.center.x, Background.center.y);
    }
    if (Ball.center.y > Player.center.y) {
        ScoreComputer++;
        ComputerScore.text = [NSString stringWithFormat:@"%i",ScoreComputer];
        ComputerScore.hidden = NO;
        PlayerScore.hidden = NO;
        StartButton.hidden = NO;
        Exit.hidden = NO;
        X = 0;
        Y = 0;
        Ball.center = CGPointMake(Background.center.x, Background.center.y);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *SoundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Clang" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)SoundURL, &PlaySoundID);

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(BallMovement) userInfo:nil repeats:YES];
    Speed = 1;
    X = 0;
    Y = 0;
}

- (void)viewWillDisappear:(BOOL)animated {

    //if(timer)
    //{
        [timer invalidate];
        timer = nil;
    //}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
