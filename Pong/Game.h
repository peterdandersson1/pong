//
//  Game.h
//  Pong
//
//  Created by IT-Högskolan on 2015-03-01.
//  Copyright (c) 2015 IT-Högskolan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

int Y;
int X;
int ScorePlayer;
int ScoreComputer;
int Speed;

@interface Game : UIViewController{

    IBOutlet UIImageView *Ball;
    IBOutlet UIView *LeftBoard;
    IBOutlet UIView *RightBoard;
    IBOutlet UIView *Player;
    IBOutlet UIView *Computer;
    IBOutlet UIView *Background;
    IBOutlet UIButton *StartButton;
    IBOutlet UIButton *Exit;
    IBOutlet UILabel *PlayerScore;
    IBOutlet UILabel *ComputerScore;
    NSTimer *timer;
    SystemSoundID PlaySoundID;
}

-(IBAction)StartButton:(id)sender;
-(void)BallMovement;
-(void)ComputerMovement;
-(void)Collision;

@end
